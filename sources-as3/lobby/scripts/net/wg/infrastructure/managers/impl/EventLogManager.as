package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import net.wg.infrastructure.base.meta.impl.EventLogManagerMeta;
   import net.wg.infrastructure.interfaces.entity.IIdentifiable;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.utils.IAssertable;
   
   public class EventLogManager extends EventLogManagerMeta implements IEventLogManager
   {
       
      
      private var _isSystemEnabled:Boolean = false;
      
      public function EventLogManager()
      {
         super();
      }
      
      public function as_setSystemEnabled(param1:Boolean) : void
      {
         this._isSystemEnabled = param1;
      }
      
      public function logUIElementDropDown(param1:DisplayObject, param2:String, param3:uint) : void
      {
         var _loc4_:IIdentifiable = this.getIdentifiable(param1);
         this.logUIElementCommon(_loc4_,param2,param3);
      }
      
      public function logUIElementLoader(param1:DisplayObject, param2:String, param3:uint) : void
      {
         var _loc4_:IIdentifiable = this.getIdentifiable(param1);
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_LOADER,param2,_loc4_.UIID,param3);
      }
      
      public function logUIElementTooltip(param1:DisplayObject, param2:String, param3:uint) : void
      {
         var _loc4_:IIdentifiable = this.getIdentifiable(param1);
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_TOOLTIP,param2,_loc4_.UIID,param3);
      }
      
      public function logUIElementViewStack(param1:DisplayObject, param2:String, param3:uint) : void
      {
         var _loc4_:IIdentifiable = this.getIdentifiable(param1);
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_VIEWSTACK,param2,_loc4_.UIID,param3);
      }
      
      public function logUIEvent(param1:Event, param2:uint) : void
      {
         var _loc3_:IIdentifiable = this.getIdentifiable(DisplayObject(param1.target));
         this.logUIElementCommon(_loc3_,param1.type,param2);
      }
      
      public function logUIEventContextMenu(param1:DisplayObject, param2:String, param3:uint) : void
      {
         var _loc4_:IIdentifiable = this.getIdentifiable(param1);
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_CONTEXT_MENU,param2,_loc4_.UIID,param3);
      }
      
      public function logUIEventContextMenuItem(param1:Event, param2:uint) : void
      {
         var _loc3_:IIdentifiable = this.getIdentifiable(DisplayObject(param1.target));
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_CONTEXT_MENU,param1.type,_loc3_.UIID,param2);
      }
      
      public function logUIEventHandleInput(param1:String, param2:uint) : void
      {
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_HANDLE_INPUT,param1,EVENT_LOG_CONSTANTS.IMAGINARY_UIID,param2);
      }
      
      public function logUIEventRenderer(param1:DisplayObject, param2:Event, param3:uint) : void
      {
         var _loc4_:IIdentifiable = this.getIdentifiable(param1);
         this.logUIElementCommon(_loc4_,param2.type,param3);
      }
      
      private function logUIElementCommon(param1:IIdentifiable, param2:String, param3:uint) : void
      {
         this.logSubSystem(EVENT_LOG_CONSTANTS.SST_UI_COMMON,param2,param1.UIID,param3);
      }
      
      private function logSubSystem(param1:uint, param2:String, param3:uint, param4:uint) : void
      {
         var _loc5_:IAssertable = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(this._isSystemEnabled)
         {
            _loc5_ = App.utils.asserter;
            if(!isDAAPIInited || param3 == Values.EMPTY_UIID)
            {
               return;
            }
            _loc6_ = "Unknown logging subsytem:" + param1;
            _loc7_ = "Unknown logged event: " + param2;
            _loc5_.assert(EVENT_LOG_CONSTANTS.SUB_SYSTEMS.indexOf(param1) != -1,_loc6_);
            _loc5_.assert(EVENT_LOG_CONSTANTS.EVENT_TYPES.indexOf(param2) != -1,_loc7_);
            logEventS(param1,param2,param3,param4);
         }
      }
      
      private function getIdentifiable(param1:DisplayObject) : IIdentifiable
      {
         App.utils.asserter.assertNotNull(param1,Errors.CANT_NULL);
         var _loc2_:IIdentifiable = null;
         var _loc3_:DisplayObject = param1;
         while(param1 != App.stage)
         {
            if(param1 is IIdentifiable)
            {
               _loc2_ = IIdentifiable(param1);
               break;
            }
            if(!param1.parent)
            {
               break;
            }
            param1 = param1.parent;
         }
         if(!_loc2_)
         {
            App.utils.asserter.assert(false,"displayObject \"" + _loc3_ + " or its parents must be implements IIdentifiable for UIID taking correctly!");
         }
         return _loc2_;
      }
   }
}
