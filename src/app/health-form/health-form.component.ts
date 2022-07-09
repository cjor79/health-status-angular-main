import { Component, Inject } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { HealthService } from '../health.service'
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { HealthStatus } from '../user';

export interface DialogData {
  status: HealthStatus;
}

@Component({
  selector: 'app-health-form',
  templateUrl: './health-form.component.html',
  styleUrls: ['./health-form.component.css']
})
export class HealthFormComponent {

  healthForm = this.formBuilder.group({
    age: '',
    height: '',
    weight: '',
    gender: '',
  });

  constructor(
    private formBuilder: FormBuilder,
    private healthService: HealthService,
    public dialog: MatDialog,
  ) {}


  openDialog(status: HealthStatus): void {
    const dialogRef = this.dialog.open(HealthStatusDialog, {
      width: '250px',
      data: {
        bfi: status.bfi,
        healthyWeight: status.healthyWeight,
        bmi: status.bmi,
        status: status.status
      },
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

  onSubmit(): void {
    console.log("algo" + this.healthForm.value);
    this.healthService.getHealthStatus(this.healthForm.value)
    .subscribe(healthStatus => this.openDialog(healthStatus));
    this.healthForm.reset();
  }

}

@Component({
  selector: 'health-status-dialog',
  templateUrl: 'health-status-dialog.html',
})
export class HealthStatusDialog {
  constructor(
    public dialogRef: MatDialogRef<HealthStatusDialog>,
    @Inject(MAT_DIALOG_DATA) public data: HealthStatus,
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

}
