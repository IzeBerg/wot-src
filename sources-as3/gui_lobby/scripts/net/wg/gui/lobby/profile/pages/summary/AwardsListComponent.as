package net.wg.gui.lobby.profile.pages.summary
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.battleResults.components.MedalsList;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AwardsListComponent extends UIComponentEx
   {
      
      private static const DP_INV:String = "dpInv";
      
      private static const TEXT_INVALID:String = "txtInv";
      
      private static const ERROR_TEXT_PADDING:uint = 85;
       
      
      public var textField:TextField;
      
      public var medalsList:MedalsList;
      
      private var _isToolTipShowing:Boolean;
      
      private var _label:String = "";
      
      private var _errorText:String = "";
      
      private var _titleToolTip:String;
      
      public function AwardsListComponent()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:IDataProvider = null;
         super.draw();
         if(isInvalid(DP_INV))
         {
            _loc2_ = this.medalsList.dataProvider;
            _loc1_ = Boolean(_loc2_) ? Boolean(_loc2_.length <= 0) : Boolean(true);
            invalidate(TEXT_INVALID);
         }
         if(isInvalid(TEXT_INVALID))
         {
            this.textField.autoSize = TextFieldAutoSize.CENTER;
            this.textField.text = !!_loc1_ ? this._errorText : this._label;
            this.textField.x = this.medalsList.width - this.textField.width >> 1;
            this.textField.y = !!_loc1_ ? Number(ERROR_TEXT_PADDING) : Number(0);
         }
      }
      
      override protected function onDispose() : void
      {
         this.medalsList.dispose();
         this.medalsList = null;
         this.disposeHandlers();
         this.textField = null;
         super.onDispose();
      }
      
      private function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function showToolTip() : void
      {
         if(this._titleToolTip != null)
         {
            App.toolTipMgr.showComplex(this._titleToolTip);
         }
      }
      
      private function disposeHandlers() : void
      {
         this.textField.removeEventListener(MouseEvent.ROLL_OVER,this.onTextFieldRollOverHandler);
         this.textField.removeEventListener(MouseEvent.ROLL_OUT,this.onTextFieldRollOutHandler);
      }
      
      public function set dataProvider(param1:DataProvider) : void
      {
         this.medalsList.dataProvider = param1;
         invalidate(DP_INV);
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         invalidate(TEXT_INVALID);
      }
      
      public function set errorText(param1:String) : void
      {
         this._errorText = param1;
         invalidate(TEXT_INVALID);
      }
      
      public function set titleToolTip(param1:String) : void
      {
         this._titleToolTip = param1;
         if(this._isToolTipShowing)
         {
            this.hideToolTip();
         }
         this.disposeHandlers();
         if(this._titleToolTip != null && this._titleToolTip != "")
         {
            this.textField.addEventListener(MouseEvent.ROLL_OVER,this.onTextFieldRollOverHandler,false,0,true);
            this.textField.addEventListener(MouseEvent.ROLL_OUT,this.onTextFieldRollOutHandler,false,0,true);
         }
      }
      
      private function onTextFieldRollOverHandler(param1:MouseEvent) : void
      {
         this._isToolTipShowing = true;
         this.showToolTip();
      }
      
      private function onTextFieldRollOutHandler(param1:MouseEvent) : void
      {
         this._isToolTipShowing = false;
         this.hideToolTip();
      }
   }
}
