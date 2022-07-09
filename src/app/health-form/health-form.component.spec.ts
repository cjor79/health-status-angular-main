import { ComponentFixture, TestBed } from '@angular/core/testing';
import { FormBuilder } from '@angular/forms';
import { HttpClient, HttpHandler } from '@angular/common/http';
import { HealthFormComponent } from './health-form.component';
import { MatDialog } from '@angular/material/dialog';
import { Overlay } from '@angular/cdk/overlay'

describe('HealthFormComponent', () => {
  let component: HealthFormComponent;
  let fixture: ComponentFixture<HealthFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ HealthFormComponent ],
      providers: [ 
        FormBuilder,
        HttpClient,
        HttpHandler,
        MatDialog,
        Overlay
      ],
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  
  /*it('should create', () => {
    expect(component).toBeTruthy();
  });*/
});
