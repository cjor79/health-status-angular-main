import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { environment } from './../environments/environment';
import { HealthStatus, User } from './user';

@Injectable({
  providedIn: 'root'
})
export class HealthService {

  constructor(private http: HttpClient) { }

  private handleError(error: HttpErrorResponse) {
    if (error.status === 0) {
      console.error('An error occurred:', error.error);
    } else {

      console.error(
        `Backend returned code ${error.status}, body was: `, error.error);
    }
    return throwError(
      'Something bad happened; please try again later.');
  }

  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
    })
  };

  getHealthStatus(user: User): Observable<HealthStatus> {
    console.log("calling health service with: ", user);
    console.log("environment.apiUrl: ", environment.apiUrl);
    console.log("this.httpOptions: ", this.httpOptions);
    return this.http.post<HealthStatus>(environment.apiUrl, user, this.httpOptions)
  }
}
