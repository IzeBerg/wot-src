package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.IPopoverManagerMeta;
   import net.wg.infrastructure.base.meta.impl.PopoverManagerMeta;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import net.wg.infrastructure.interfaces.IClosePopoverCallback;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.interfaces.IPopoverWrapper;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.IPopoverManager;
   
   public class PopoverManagerBase extends PopoverManagerMeta implements IPopoverManagerMeta, IPopoverManager
   {
       
      
      private var _stage:Stage;
      
      private var _popoverCaller:IPopOverCaller;
      
      private var _client:IClosePopoverCallback = null;
      
      public function PopoverManagerBase(param1:Stage)
      {
         super();
         this._stage = param1;
      }
      
      public function as_onPopoverDestroy() : void
      {
         if(this._popoverCaller)
         {
            if(this._stage != null)
            {
               this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler,true);
            }
            if(this._client != null)
            {
               this._client.onPopoverClose();
            }
            this._popoverCaller = null;
         }
         this._client = null;
      }
      
      override protected function onDispose() : void
      {
         this._popoverCaller = null;
         this._client = null;
         this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler,true);
         this._stage = null;
         super.onDispose();
      }
      
      public function hide() : void
      {
         requestHidePopoverS();
      }
      
      public function isPopover(param1:IView) : Boolean
      {
         return false;
      }
      
      public function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null) : void
      {
         App.utils.asserter.assertNotNull(param1,"popoverCaller" + Errors.CANT_NULL,NullPointerException);
         App.utils.asserter.assertNotNull(param2,"alias" + Errors.CANT_NULL,NullPointerException);
         if(this._popoverCaller == param1)
         {
            this.hide();
            return;
         }
         this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler,true,0,true);
         this._popoverCaller = param1;
         this._client = param4;
         requestShowPopoverS(param2,param3);
         if(this._client)
         {
            this._client.onPopoverOpen();
         }
      }
      
      protected function isCheckingCandidateValid(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject) : Boolean
      {
         while(param1)
         {
            if(param1 == param3 || param1 == param2 || param1 is IPopoverWrapper)
            {
               return false;
            }
            param1 = param1.parent;
         }
         return true;
      }
      
      public function get popoverCaller() : IPopOverCaller
      {
         return this._popoverCaller;
      }
      
      public function set popoverCaller(param1:IPopOverCaller) : void
      {
         App.utils.asserter.assertNotNull(param1,"popoverCaller" + Errors.CANT_NULL,NullPointerException);
         if(this._popoverCaller == param1)
         {
            return;
         }
         if(this._popoverCaller != null)
         {
            this.hide();
         }
         this._popoverCaller = param1;
         this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler,true,0,true);
      }
      
      private function onStageMouseDownHandler(param1:MouseEvent) : void
      {
         App.utils.asserter.assertNotNull(this._popoverCaller,this + " _lastPopoverCaller have not to be NULL!",NullPointerException);
         if(!(param1.target is DisplayObject))
         {
            return;
         }
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         var _loc3_:DisplayObject = this._popoverCaller.getHitArea();
         var _loc4_:DisplayObject = this._popoverCaller.getTargetButton();
         if(!this.isCheckingCandidateValid(_loc2_,_loc3_,_loc4_))
         {
            return;
         }
         this.hide();
      }
   }
}
