-- Event Package --
CREATE OR REPLACE PACKAGE Event_Naddlk_API

IS
  -- Insert Procedure --
  PROCEDURE Insert_Event_Naddlk(
  event_name_ IN VARCHAR2, event_date_ IN DATE, event_time_ IN VARCHAR2, event_category_ IN VARCHAR2, 
  event_organizer_ IN VARCHAR2, event_description_ IN VARCHAR2, ticket_price_ NUMBER);
  
  -- Update Procedure --       
  PROCEDURE Update_Event_Naddlk(
  event_id_ IN NUMBER, event_name_ IN VARCHAR2, event_date_ IN DATE, event_time_ IN VARCHAR2, event_category_ IN VARCHAR2, 
  event_organizer_ IN VARCHAR2, event_description_ IN VARCHAR2, ticket_price_ NUMBER);
  
  -- Delete Procedure --         
  PROCEDURE Delete_Event_Naddlk(
  event_id_ IN NUMBER);
  
  -- Retrieve Procedure
  PROCEDURE Retrieve_Event_Naddlk(
  event_cursor_ OUT SYS_REFCURSOR);

END Event_Naddlk_API;


-- Event Package Body --

CREATE OR REPLACE PACKAGE BODY Event_Naddlk_API

IS
  --Insert Procedure----------------------
  PROCEDURE Insert_Event_Naddlk(
  event_name_ IN VARCHAR2, event_date_ IN DATE, event_time_ IN VARCHAR2, event_category_ IN VARCHAR2, 
  event_organizer_ IN VARCHAR2, event_description_ IN VARCHAR2, ticket_price_ NUMBER)
           
  IS
           
  BEGIN
    INSERT INTO events_naddlk
    (event_name, event_date, event_time, event_category, event_organizer, event_description, ticket_price) 
    VALUES (event_name_, to_date(event_date_,'dd/mm/yyyy'), event_time_, event_category_, event_organizer_,
    event_description_, ticket_price_);
    --commit;
  
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      Dbms_Output.Put_Line('Primary key already found');
    WHEN VALUE_ERROR THEN
      Dbms_Output.Put_Line('Input values Do not satisfy the constrains');
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Insert_Event_Naddlk;
  
--Update Event Procedure --------------------------------------------------

  PROCEDURE Update_Event_Naddlk(
  event_id_ IN NUMBER, event_name_ IN VARCHAR2, event_date_ IN DATE, event_time_ IN VARCHAR2, event_category_ IN VARCHAR2, 
  event_organizer_ IN VARCHAR2, event_description_ IN VARCHAR2, ticket_price_ NUMBER)
             
  IS
    temp_ events_naddlk%ROWTYPE;
    CURSOR cur is 
    SELECT * FROM events_naddlk;
                  
  BEGIN
    OPEN cur;      
    FETCH cur INTO temp_;
    IF(cur%FOUND) THEN
      UPDATE events_naddlk 
      SET event_name = event_name_, event_date = to_date(event_date_,'dd/mm/yyyy'),
      event_time = event_time_, event_category = event_category_,
      event_organizer = event_organizer_, event_description = event_description_,
      ticket_price = ticket_price_ WHERE event_id = event_id_;
      CLOSE cur;
    ELSIF (cur%NOTFOUND) THEN
      CLOSE cur;
    END IF; 
    --commit;     
             
  EXCEPTION
    WHEN VALUE_ERROR THEN
      Dbms_Output.Put_Line('Input values Do not satisfy the constrains');
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Update_Event_Naddlk;

-- Delete Procedure---------------------------------------------------
  PROCEDURE Delete_Event_Naddlk(
  event_id_ IN NUMBER)
             
  IS
    temp_ events_naddlk%ROWTYPE;
    CURSOR cur is 
    SELECT * FROM events_naddlk;
                  
  BEGIN
    OPEN cur;
    FETCH cur INTO temp_;
    IF(cur%FOUND) THEN
      DELETE FROM events_naddlk WHERE event_id = event_id_;
      CLOSE cur;
    ELSIF (cur%NOTFOUND) THEN
      CLOSE cur;
    END IF;
    commit;
            
  EXCEPTION
    WHEN VALUE_ERROR THEN
      Dbms_Output.Put_Line('Input values Do not satisfy the constrains');
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Delete_Event_Naddlk;

--Retrieve Data Procedure-------------------------------------------  
  PROCEDURE Retrieve_Event_Naddlk(
  event_cursor_ OUT SYS_REFCURSOR)
             
  IS
                  
  BEGIN
    OPEN event_cursor_ FOR
    SELECT * FROM events_naddlk e ORDER BY e.event_id;
    --commit;
              
  EXCEPTION
    WHEN OTHERS THEN
      Dbms_output.put_line('Unidentified error occurred');
  END Retrieve_Event_Naddlk;

END Event_Naddlk_API;
