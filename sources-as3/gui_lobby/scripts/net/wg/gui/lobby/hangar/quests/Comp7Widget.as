package net.wg.gui.lobby.hangar.quests
{
   import flash.display.BlendMode;
   import flash.events.Event;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.components.controls.Image;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class Comp7Widget extends GFInjectComponent implements IHeaderFlagsEntryPoint
   {
      
      private static const WIDTH:int = 300;
      
      private static const HEIGHT:int = 230;
      
      private static const MARGIN_LEFT:int = -75;
      
      private static const MARGIN_LEFT_SMALL:int = -85;
      
      private static const MARGIN_RIGHT:int = -75;
      
      private static const MARGIN_RIGHT_SMALL:int = -85;
      
      private static const MARGIN_TOP:int = 0;
      
      private static const BG_POS_X:int = -57;
       
      
      private var _isSmall:Boolean = false;
      
      private var _bgImage:Image = null;
      
      public function Comp7Widget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
         width = WIDTH;
         height = HEIGHT;
         x = -(WIDTH >> 1);
         this._bgImage = new Image();
         this._bgImage.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this._bgImage.blendMode = BlendMode.ADD;
         this._bgImage.tabEnabled = this._bgImage.mouseEnabled = this._bgImage.mouseChildren = false;
         this._bgImage.source = RES_ICONS.MAPS_ICONS_COMP7_BACKGROUNDS_HANGAR_WIDGET_BG;
         this._bgImage.x = BG_POS_X;
         addChild(this._bgImage);
         App.utils.commons.addEmptyHitArea(this._bgImage);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this._isSmall = App.stage.stageHeight <= StageSizeBoundaries.HEIGHT_900;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         this._bgImage.hitArea = null;
         this._bgImage.dispose();
         this._bgImage = null;
         super.onDispose();
      }
      
      public function get marginRight() : int
      {
         return !!this._isSmall ? int(MARGIN_RIGHT_SMALL) : int(MARGIN_RIGHT);
      }
      
      public function get marginLeft() : int
      {
         return !!this._isSmall ? int(MARGIN_LEFT_SMALL) : int(MARGIN_LEFT);
      }
      
      public function get marginTop() : int
      {
         return MARGIN_TOP;
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
