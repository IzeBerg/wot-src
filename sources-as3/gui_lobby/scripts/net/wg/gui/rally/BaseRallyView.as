package net.wg.gui.rally
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
   import net.wg.infrastructure.base.meta.impl.BaseRallyViewMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class BaseRallyView extends BaseRallyViewMeta implements IBaseRallyViewMeta
   {
      
      public static const DEFAULT_STRING:String = "";
       
      
      public var titleLbl:TextField;
      
      public var descrLbl:TextField;
      
      public var backBtn:ISoundButtonEx;
      
      public var createBtn:ISoundButtonEx;
      
      private var _coolDownRequests:Array;
      
      public function BaseRallyView()
      {
         this._coolDownRequests = [];
         super();
      }
      
      public function isInCoolDown(param1:int) : Boolean
      {
         return this._coolDownRequests.indexOf(param1) > -1;
      }
      
      public function as_setCoolDown(param1:Number, param2:int) : void
      {
         if(!this.isInCoolDown(param2))
         {
            this.coolDownControls(false,param2);
            App.utils.scheduler.scheduleNonCancelableTask(this.coolDownControls,param1 * 1000,true,param2);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.createBtn)
         {
            this.createBtn.addEventListener(ButtonEvent.CLICK,this.onCreateButtonClickHandler);
            this.createBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.createBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         }
         if(this.backBtn)
         {
            this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackClickHandler);
            this.backBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.backBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.coolDownControls);
         if(this.backBtn)
         {
            this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackClickHandler);
            this.backBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.backBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            this.backBtn.dispose();
            this.backBtn = null;
         }
         if(this.createBtn)
         {
            this.createBtn.removeEventListener(ButtonEvent.CLICK,this.onCreateButtonClickHandler);
            this.createBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.createBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            this.createBtn.dispose();
            this.createBtn = null;
         }
         this.titleLbl = null;
         this.descrLbl = null;
         this._coolDownRequests = null;
         App.contextMenuMgr.hide();
         super.onDispose();
      }
      
      protected function coolDownControls(param1:Boolean, param2:int) : void
      {
         var _loc3_:int = this._coolDownRequests.indexOf(param2);
         if(param1)
         {
            if(_loc3_ > -1)
            {
               this._coolDownRequests.splice(_loc3_,1);
            }
         }
         else if(_loc3_ == -1)
         {
            this._coolDownRequests.push(param2);
         }
      }
      
      protected function getRallyViewAlias() : String
      {
         return DEFAULT_STRING;
      }
      
      protected function showComplexTooltip(param1:String, param2:String) : void
      {
         var _loc3_:String = App.toolTipMgr.getNewFormatter().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         this.controlRollOverPerformer(param1);
      }
      
      protected function controlRollOverPerformer(param1:MouseEvent = null) : void
      {
      }
      
      private function onCreateButtonClickHandler(param1:ButtonEvent) : void
      {
         this.onCreateButtonClick();
      }
      
      protected function onCreateButtonClick() : void
      {
         var _loc1_:Object = {
            "alias":this.getRallyViewAlias(),
            "itemId":Number.NaN,
            "peripheryID":0,
            "slotIndex":-1
         };
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc1_));
      }
      
      private function onBackClickHandler(param1:ButtonEvent) : void
      {
         this.onControlRollOut();
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.BACK_NAVIGATION_REQUEST));
      }
      
      private function onControlRollOutHandler(param1:Event) : void
      {
         this.onControlRollOut();
      }
      
      protected function onControlRollOut() : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function canShowAutomatically() : Boolean
      {
         return true;
      }
   }
}
