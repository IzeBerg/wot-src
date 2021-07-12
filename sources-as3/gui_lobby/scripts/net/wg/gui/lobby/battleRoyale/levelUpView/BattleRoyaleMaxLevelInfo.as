package net.wg.gui.lobby.battleRoyale.levelUpView
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleRoyaleMaxLevelInfo extends UIComponentEx implements IDisposable
   {
      
      private static const ICON_TEXT_GAP_X:int = 0;
      
      private static const TEXT_GAP_Y:int = 10;
      
      private static const ICON_SIZE_SMALL:int = 114;
      
      private static const ICON_SIZE_NORMAL:int = 164;
       
      
      public var icon:Sprite = null;
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      private var _isSmall:Boolean = false;
      
      private var _iconSize:int = 164;
      
      public function BattleRoyaleMaxLevelInfo()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTF.text = BATTLE_ROYALE.LEVEL_UP_MAX_LEVEL_INFO_TITLE;
         App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
         this.descriptionTF.text = BATTLE_ROYALE.LEVEL_UP_MAX_LEVEL_INFO_DESCRIPTION;
         App.utils.commons.updateTextFieldSize(this.descriptionTF,true,false);
      }
      
      override protected function onDispose() : void
      {
         this.descriptionTF = null;
         this.titleTF = null;
         this.icon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.icon.width = this.icon.height = this._iconSize;
            _loc1_ = this.icon.width + ICON_TEXT_GAP_X + Math.max(this.titleTF.width,this.descriptionTF.width);
            this.icon.x = -_loc1_ >> 1;
            this.titleTF.x = this.descriptionTF.x = this.icon.x + this.icon.width + ICON_TEXT_GAP_X | 0;
            _loc2_ = this.titleTF.height + TEXT_GAP_Y + this.descriptionTF.height;
            this.titleTF.y = this.icon.height - _loc2_ >> 1;
            this.descriptionTF.y = this.titleTF.y + this.titleTF.height + TEXT_GAP_Y;
         }
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(param1 != this._isSmall)
         {
            this._isSmall = param1;
            this._iconSize = !!this._isSmall ? int(ICON_SIZE_SMALL) : int(ICON_SIZE_NORMAL);
            invalidateSize();
         }
      }
      
      override public function get height() : Number
      {
         return this._iconSize;
      }
   }
}
