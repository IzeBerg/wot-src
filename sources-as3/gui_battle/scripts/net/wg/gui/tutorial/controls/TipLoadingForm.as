package net.wg.gui.tutorial.controls
{
   import flash.text.TextField;
   import net.wg.gui.battle.battleloading.BaseLoadingForm;
   
   public class TipLoadingForm extends BaseLoadingForm
   {
      
      private static const INVALID_TIP:String = "invalidTip";
       
      
      public var helpTip:TextField;
      
      public var tipText:TextField;
      
      private var _tipTitleStr:String;
      
      private var _tipBodyStr:String;
      
      public function TipLoadingForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         battleIcon.width = 104;
         battleIcon.height = 104;
         battleIcon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_136X136_TUTORIAL;
      }
      
      override protected function onDispose() : void
      {
         this.helpTip = null;
         this.tipText = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_TIP))
         {
            if(this.helpTip != null && this._tipTitleStr != null)
            {
               this.helpTip.htmlText = this._tipTitleStr;
            }
            this.tipText.htmlText = this._tipBodyStr;
         }
      }
      
      public function updateTipBody(param1:String) : void
      {
         if(param1 != this._tipBodyStr)
         {
            this._tipBodyStr = param1;
            invalidate(INVALID_TIP);
         }
      }
      
      public function updateTipTitle(param1:String) : void
      {
         if(param1 != this._tipTitleStr)
         {
            this._tipTitleStr = param1;
            invalidate(INVALID_TIP);
         }
      }
      
      public function updateTipVisibility(param1:Boolean) : void
      {
         this.helpTip.visible = param1;
         this.tipText.visible = param1;
      }
   }
}
