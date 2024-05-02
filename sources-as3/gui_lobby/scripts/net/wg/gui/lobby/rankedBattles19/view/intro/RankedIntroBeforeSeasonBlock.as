package net.wg.gui.lobby.rankedBattles19.view.intro
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.rankedBattles19.data.RankedIntroBeforeSeasonBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedIntroBeforeSeasonBlock extends UIComponentEx
   {
      
      private static const ICON_GAP:int = -7;
      
      private static const ICON_X_SHIFT:int = -5;
      
      private static const ICON_Y_SHIFT:int = 2;
       
      
      public var titleTf:TextField = null;
      
      public var timeTf:TextField = null;
      
      public var icon:IImage = null;
      
      public var bg:Sprite = null;
      
      private var _data:RankedIntroBeforeSeasonBlockVO = null;
      
      private var _commons:ICommons;
      
      public function RankedIntroBeforeSeasonBlock()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data == null)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.iconSrc;
            this.titleTf.htmlText = this._data.title;
            this.timeTf.htmlText = this._data.time;
            this._commons.updateTextFieldSize(this.timeTf,true,false);
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.icon.x = (this.titleTf.width - this.timeTf.width - this.icon.width - ICON_GAP >> 1) + ICON_X_SHIFT;
            this.timeTf.x = this.icon.x + this.icon.width + ICON_GAP;
            this.icon.y = this.timeTf.y - (this.icon.height - this.timeTf.height >> 1) + ICON_Y_SHIFT;
            this.bg.x = (this.timeTf.width - this.bg.width >> 1) + this.timeTf.x;
            this.bg.y = (this.timeTf.height - this.bg.height >> 1) + this.timeTf.y;
         }
      }
      
      override public function get width() : Number
      {
         return this.titleTf.width;
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.titleTf = null;
         this.timeTf = null;
         this.bg = null;
         this._data = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setData(param1:RankedIntroBeforeSeasonBlockVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
