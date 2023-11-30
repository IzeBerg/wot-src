package net.wg.gui.lobby.personalMissions.components.awardsView
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.personalMissions.data.PMAwardHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class AwardHeader extends UIComponentEx
   {
      
      private static const ICON_HORIZONTAL_MARGIN:int = -9;
      
      private static const FONT_SIZE_COMPACT:int = 38;
      
      private static const FONT_SIZE:int = 48;
       
      
      public var descriptionTf:TextField = null;
      
      public var levelTf:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var titleTf:TextField = null;
      
      private var _data:PMAwardHeaderVO = null;
      
      private var _isCompact:Boolean = false;
      
      private var _tFormat:TextFormat = null;
      
      public function AwardHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tFormat = this.levelTf.getTextFormat();
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.descriptionTf = null;
         this.levelTf = null;
         this.titleTf = null;
         this.icon.dispose();
         this.icon = null;
         this._tFormat = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.descriptionTf.text = this._data.description;
            this.levelTf.text = this._data.level;
            this.titleTf.text = this._data.title;
            this.icon.source = this._data.vehIcon;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this._tFormat.size = !!this._isCompact ? FONT_SIZE_COMPACT : FONT_SIZE;
            this.levelTf.setTextFormat(this._tFormat);
            this.titleTf.setTextFormat(this._tFormat);
            _loc1_ = this.levelTf.textWidth + this.titleTf.textWidth + this.icon.originalWidth + (ICON_HORIZONTAL_MARGIN << 1);
            this.levelTf.x = -(_loc1_ >> 1);
            this.icon.x = this.levelTf.x + this.levelTf.textWidth + ICON_HORIZONTAL_MARGIN;
            this.titleTf.x = this.icon.x + this.icon.originalWidth + ICON_HORIZONTAL_MARGIN;
         }
      }
      
      public function isCompact(param1:Boolean) : void
      {
         if(this._isCompact == param1)
         {
            return;
         }
         this._isCompact = param1;
         invalidateSize();
      }
      
      public function setData(param1:PMAwardHeaderVO) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}
