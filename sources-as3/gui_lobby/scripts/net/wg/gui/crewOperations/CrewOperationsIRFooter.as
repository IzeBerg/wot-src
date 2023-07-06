package net.wg.gui.crewOperations
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CrewOperationsIRFooter extends UIComponentEx
   {
       
      
      public var button:SoundButtonEx;
      
      public var warning:MovieClip;
      
      public var errorText:TextField;
      
      public var separator:MovieClip;
      
      private var _tooltip:String;
      
      private var _data:CrewOperationInfoVO;
      
      private var separatorBottomPadding:int;
      
      public function CrewOperationsIRFooter()
      {
         super();
      }
      
      private static function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.errorText.mouseEnabled = false;
         this.errorText.visible = false;
         this.button.visible = this.warning.visible = false;
         this.separatorBottomPadding = this.button.y + this.button.height - this.separator.y;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            _loc1_ = this._data.error != Values.EMPTY_STR;
            if(_loc1_)
            {
               this.errorText.text = this._data.error;
               this.errorText.visible = true;
               this.warning.visible = false;
               this.button.visible = false;
               this.separator.y = Math.round(this.errorText.y + this.errorText.textHeight - this.separatorBottomPadding);
            }
            else
            {
               this.errorText.visible = false;
               this.button.visible = true;
               this.button.label = this._data.btnLabel;
               _loc2_ = this._data.warningVO != null;
               this.warning.visible = _loc2_;
               this.button.enabled = true;
               if(_loc2_)
               {
                  this.button.enabled = this._data.warningVO.operationAvailable;
                  this.toolTip = this._data.warningVO.tooltipId;
               }
               this.separator.y = Math.round(this.button.y + this.button.height - this.separatorBottomPadding);
            }
            _height = Math.round(this.separator.y + this.separator.height);
         }
      }
      
      public function set toolTip(param1:String) : void
      {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._tooltip)
         {
            this.warning.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            this.warning.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
         }
      }
      
      protected function mouseRollOverHandler(param1:MouseEvent) : void
      {
         this.showToolTip(null);
      }
      
      protected function mouseRollOutHandler(param1:MouseEvent) : void
      {
         hideToolTip();
      }
      
      protected function showToolTip(param1:IToolTipParams) : void
      {
         if(this._tooltip)
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
      
      private function disposeHandlers() : void
      {
         this.warning.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         this.warning.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
      }
      
      public function get data() : CrewOperationInfoVO
      {
         return this._data;
      }
      
      public function set data(param1:CrewOperationInfoVO) : void
      {
         this._data = param1;
         invalidateData();
         if(this._data.btnNotificationEnabled)
         {
            App.utils.counterManager.setCounter(this.button,MENU.HEADER_NOTIFICATIONSIGN);
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.counterManager.removeCounter(this.button);
         this.button.dispose();
         this.button = null;
         this._data = null;
         this.disposeHandlers();
         super.onDispose();
      }
   }
}
