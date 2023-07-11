-- Event Package --
CREATE OR REPLACE PACKAGE Booking_Naddlk_API

IS
  -- Insert Procedure --
  PROCEDURE Insert_Booking_Naddlk(
  event_id_ NUMBER);
  
  -- Update Procedure --       
  PROCEDURE Update_Booking_Naddlk(
  booking_id_ IN NUMBER, event_id_ IN NUMBER);
  
  -- Delete Procedure --         
  PROCEDURE Delete_Booking_Naddlk(
  booking_id_ IN NUMBER);
  
  -- Retrieve Procedure
  PROCEDURE Retrieve_Booking_Naddlk(
  event_cursor_ OUT SYS_REFCURSOR);

END Booking_Naddlk_API;


-- Event Package Body --

CREATE OR REPLACE PACKAGE BODY Booking_Naddlk_API

IS
  --Insert Procedure----------------------
  PROCEDURE Insert_Booking_Naddlk(
  event_id_ NUMBER)
           
  IS
           
  BEGIN
    INSERT INTO booking_naddlk
    (booking_date, user_id, event_id) 
    VALUES (to_date(sysdate,'dd/mm/yyyy'), 1, event_id_);
  
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      Dbms_Output.Put_Line('Primary key already found');
    WHEN VALUE_ERROR THEN
      Dbms_Output.Put_Line('Input values Do not satisfy the constrains');
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Insert_Booking_Naddlk;
  
--Update Event Procedure --------------------------------------------------

  PROCEDURE Update_Booking_Naddlk(
  booking_id_ IN NUMBER, event_id_ IN NUMBER)
             
  IS
    temp_ booking_naddlk%ROWTYPE;
    CURSOR cur is 
    SELECT * FROM booking_naddlk;
                  
  BEGIN
    OPEN cur;      
    FETCH cur INTO temp_;
    IF(cur%FOUND) THEN
      UPDATE booking_naddlk 
      SET booking_date = to_date(sysdate,'dd/mm/yyyy'), event_id = event_id_;
      CLOSE cur;
    ELSIF (cur%NOTFOUND) THEN
      CLOSE cur;
    END IF;      
             
  EXCEPTION
    WHEN VALUE_ERROR THEN
      Dbms_Output.Put_Line('Input values Do not satisfy the constrains');
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Update_Booking_Naddlk;

-- Delete Procedure---------------------------------------------------
  PROCEDURE Delete_Booking_Naddlk(
  booking_id_ IN NUMBER)
             
  IS
    temp_ booking_naddlk%ROWTYPE;
    CURSOR cur is 
    SELECT * FROM booking_naddlk;
                  
  BEGIN
    OPEN cur;
    FETCH cur INTO temp_;
    IF(cur%FOUND) THEN
      DELETE FROM booking_naddlk WHERE booking_id = booking_id_;
      CLOSE cur;
    ELSIF (cur%NOTFOUND) THEN
      CLOSE cur;
    END IF;
            
  EXCEPTION
    WHEN VALUE_ERROR THEN
      Dbms_Output.Put_Line('Input values Do not satisfy the constrains');
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Delete_Booking_Naddlk;

--Retrieve Data Procedure-------------------------------------------  
  PROCEDURE Retrieve_Booking_Naddlk(
  event_cursor_ OUT SYS_REFCURSOR)
             
  IS
                  
  BEGIN
    OPEN event_cursor_ FOR
    SELECT * FROM booking_naddlk e ORDER BY e.booking_id;
              
  EXCEPTION
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Retrieve_Booking_Naddlk;

END Booking_Naddlk_API;
