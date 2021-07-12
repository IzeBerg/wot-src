package net.wg.infrastructure.managers.impl.cursor.base
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   import net.wg.utils.IAssertable;
   
   public class BaseInfo implements IDisposable
   {
      
      public static const STATE_NONE:String = "none";
      
      public static const STATE_INITIALIZED:String = "initialized";
      
      public static const STATE_STARTED:String = "started";
      
      private static const DRAG_STATES:Vector.<String> = Vector.<String>([STATE_NONE,STATE_INITIALIZED,STATE_STARTED]);
      
      private static const DRAG_DROP_OBJ_STR:String = "dragDropObject ";
      
      private static const UNKNOWN_DRAG_STATE:String = "Unknown drag state: ";
       
      
      private var _cursor:String = "";
      
      private var _container:IDragDropHitArea = null;
      
      private var _processState:String = "none";
      
      private var _asserter:IAssertable;
      
      public function BaseInfo(param1:IDragDropHitArea, param2:String, param3:String)
      {
         this._asserter = App.utils.asserter;
         super();
         this._asserter.assertNotNull(param1,DRAG_DROP_OBJ_STR + Errors.CANT_NULL);
         this._asserter.assert(param1 is InteractiveObject,DRAG_DROP_OBJ_STR + param1 + Values.SPACE_STR + Errors.INVALID_TYPE + InteractiveObject);
         this._container = param1;
         this._cursor = Boolean(param2) ? param2 : param3;
      }
      
      public static function getHitFromContainer(param1:IDragDropHitArea) : InteractiveObject
      {
         var _loc2_:InteractiveObject = param1.getHitArea();
         return Boolean(_loc2_) ? _loc2_ : InteractiveObject(param1);
      }
      
      public final function dispose() : void
      {
         this._cursor = null;
         this._container = null;
         this._processState = null;
         this._asserter = null;
      }
      
      protected final function getContainer() : IDragDropHitArea
      {
         return this._container;
      }
      
      protected final function getCursor() : String
      {
         return this._cursor;
      }
      
      public function get hit() : InteractiveObject
      {
         return BaseInfo.getHitFromContainer(this._container);
      }
      
      public function get cursor() : String
      {
         return this._cursor;
      }
      
      public function get state() : String
      {
         return this._processState;
      }
      
      public function set state(param1:String) : void
      {
         if(this._processState == param1)
         {
            return;
         }
         this._asserter.assert(DRAG_STATES.indexOf(param1) != -1,UNKNOWN_DRAG_STATE + param1);
         this._processState = param1;
      }
   }
}
