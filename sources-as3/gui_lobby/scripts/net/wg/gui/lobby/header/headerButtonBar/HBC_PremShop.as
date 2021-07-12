package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
   import scaleform.clik.utils.Padding;
   
   public class HBC_PremShop extends HeaderButtonContentItem
   {
      
      private static const TEXT_OFFSET_MIN:int = 12;
      
      private static const TEXT_OFFSET_DEF:int = 20;
      
      private static const MAX_SCREEN_PRC_BORDER:Number = 0.33;
      
      private static const MAG_GLOW_BG_WIDTH:int = 115;
      
      private static const ICON_WIDTH:int = 52;
       
      
      public var icon:Image = null;
      
      public var bigBg:Sprite = null;
      
      public var smallBg:Sprite = null;
      
      public var premShopTF:TextField = null;
      
      private var _model:HBC_PremShopVO = null;
      
      private var _curTextOffset:Number = 0;
      
      public function HBC_PremShop()
      {
         super();
         this._curTextOffset = TEXT_OFFSET_DEF;
         minScreenPadding = new Padding(0,0,0,0);
         wideScreenPrc = 0;
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.bigBg = null;
         this.smallBg = null;
         this.premShopTF = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:Boolean = false;
         if(data != null)
         {
            this.icon.source = this._model.iconSrc;
            this.premShopTF.text = this._model.premShopText;
            _loc1_ = maxScreenPrc > MAX_SCREEN_PRC_BORDER;
            this._curTextOffset = !!_loc1_ ? Number(TEXT_OFFSET_DEF) : Number(TEXT_OFFSET_MIN);
            if(_loc1_)
            {
               this.premShopTF.visible = true;
               bounds.width = Math.max(this.premShopTF.x + this.premShopTF.textWidth + this._curTextOffset,MAG_GLOW_BG_WIDTH);
            }
            else
            {
               this.premShopTF.visible = false;
               bounds.width = this.icon.x + ICON_WIDTH;
            }
            this.smallBg.visible = !_loc1_;
            this.bigBg.visible = _loc1_;
         }
         super.updateData();
      }
      
      override protected function get leftPadding() : Number
      {
         return minScreenPadding.left;
      }
      
      override protected function get rightPadding() : Number
      {
         return minScreenPadding.right;
      }
      
      override public function set data(param1:Object) : void
      {
         this._model = HBC_PremShopVO(param1);
         super.data = param1;
      }
   }
}
