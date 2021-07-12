package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.text.TextField;
   import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
   
   public class HBC_AccountUpper extends HBC_Upper
   {
      
      private static const TEXT_LEFT_OFFSET:int = -12;
      
      private static const TEXT_TOP_OFFSET:int = 14;
      
      private static const ICON_WIDTH_DEFAULT:int = 48;
       
      
      public var upperText:TextField = null;
      
      private var _data:HBC_AccountDataVo = null;
      
      public function HBC_AccountUpper()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.upperText = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         var _loc1_:int = upperIcon.width;
         var _loc2_:int = _loc1_ > ICON_WIDTH_DEFAULT ? int(ICON_WIDTH_DEFAULT - _loc1_) : int(0);
         this.upperText.x = upperIcon.x + _loc1_ + _loc2_ + TEXT_LEFT_OFFSET ^ 0;
         this.upperText.y = upperIcon.y + TEXT_TOP_OFFSET ^ 0;
      }
      
      override protected function updateData() : void
      {
         if(this._data != null)
         {
            this.visible = this._data.hasActiveBooster || this._data.hasAvailableBoosters;
            loadAssets(this._data.boosterBg,this._data.boosterIcon);
            this.upperText.htmlText = this._data.boosterText;
         }
         super.updateData();
      }
      
      override public function set data(param1:Object) : void
      {
         this._data = HBC_AccountDataVo(param1);
         super.data = param1;
      }
   }
}
