package net.wg.gui.battle.pveBase.views.minimap
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.PveFullMapGridJacket;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.infrastructure.base.meta.IPveMinimapMeta;
   import net.wg.infrastructure.base.meta.impl.PveMinimapMeta;
   import scaleform.gfx.MouseEventEx;
   
   public class PveFullMap extends PveMinimapMeta implements IPveMinimapMeta
   {
      
      private static const PADDING:int = 30;
      
      private static const HEIGHT_MIN:int = 1104;
      
      private static const DIMMER_COLOR:uint = 0;
      
      private static const DIMMER_ALPHA:Number = 0.5;
      
      private static const SIMPLE_JACKET_BORDER:int = 10;
       
      
      public var entriesContainer:PveMinimapEntriesContainer = null;
      
      public var gridJacket:PveFullMapGridJacket = null;
      
      public var simpleJacket:Sprite = null;
      
      private var _clickAreaSpr:Sprite = null;
      
      private var _dimmer:Sprite = null;
      
      public function PveFullMap()
      {
         super();
         this.entriesContainer.setMinimalSize(PveFullMapConst.INITIAL_SIZE);
         this.entriesContainer.grid.setSize(PveFullMapConst.VISIBLE_SIZE,PveFullMapConst.VISIBLE_SIZE);
         var _loc1_:Number = PveFullMapConst.INITIAL_SIZE / PveMinimapConst.MINIMAL_SIZE;
         this.entriesContainer.setAdditionalLayerScale(this.entriesContainer.arrows,_loc1_,_loc1_);
         this.entriesContainer.setAdditionalLayerScale(this.entriesContainer.attention,_loc1_,_loc1_);
         this._clickAreaSpr = new Sprite();
         addChild(this._clickAreaSpr);
         this.setClickArea(PveFullMapConst.VISIBLE_SIZE);
         this.simpleJacket.visible = false;
         this.gridJacket.visible = true;
         this._dimmer = new Sprite();
         this._dimmer.name = "fullMapDimmer";
         this._dimmer.visible = false;
      }
      
      private function setClickArea(param1:int) : void
      {
         this._clickAreaSpr.graphics.clear();
         this._clickAreaSpr.graphics.beginFill(0,0);
         this._clickAreaSpr.graphics.drawRect(0,0,param1,param1);
         this._clickAreaSpr.graphics.endFill();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         MinimapEntryController.instance.updateScale(PveFullMapConst.DEFAULT_MAP_SIZE_INDEX,this);
      }
      
      override protected function onDispose() : void
      {
         this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._clickAreaSpr = null;
         this.entriesContainer.dispose();
         this.entriesContainer = null;
         this.gridJacket.dispose();
         this.gridJacket = null;
         this.simpleJacket = null;
         this._dimmer = null;
         super.onDispose();
      }
      
      public function updateStagePosition(param1:int, param2:int) : void
      {
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         super.draw();
         _loc1_ = App.instance.appWidth;
         _loc2_ = App.instance.appHeight;
         if(isInvalid(InvalidationType.SIZE))
         {
            if(_loc2_ < HEIGHT_MIN)
            {
               _loc3_ = _loc2_ - (PADDING << 1);
            }
            else
            {
               _loc3_ = PveFullMapConst.VISIBLE_SIZE + (!!this.simpleJacket.visible ? SIMPLE_JACKET_BORDER << 1 : PveFullMapGridJacket.BORDERS);
            }
            if(this.gridJacket.visible)
            {
               this.gridJacket.setSize(_loc3_);
               _loc4_ = _loc3_ - PveFullMapGridJacket.BORDERS;
            }
            else
            {
               this.simpleJacket.width = _loc3_;
               this.simpleJacket.height = _loc3_;
               _loc4_ = _loc3_ - (SIMPLE_JACKET_BORDER << 1);
            }
            x = _loc1_ - _loc3_ >> 1;
            y = _loc2_ - _loc3_ >> 1;
            this.entriesContainer.setSize(_loc4_,_loc4_);
            this.entriesContainer.grid.setSize(_loc4_,_loc4_);
            this.setClickArea(_loc4_);
            this._clickAreaSpr.x = this.entriesContainer.x = this._clickAreaSpr.y = this.entriesContainer.y = !!this.simpleJacket.visible ? Number(SIMPLE_JACKET_BORDER) : Number(PveFullMapGridJacket.THICK_BORDER);
            this._dimmer.graphics.clear();
            this._dimmer.graphics.beginFill(DIMMER_COLOR,DIMMER_ALPHA);
            this._dimmer.graphics.drawRect(0,0,_loc1_,_loc2_);
            this._dimmer.graphics.endFill();
            _loc5_ = _loc4_ / PveFullMapConst.VISIBLE_SIZE;
            this.entriesContainer.setGlobalMarkersScale(1 / _loc5_);
         }
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         this._dimmer.visible = param1;
         super.setCompVisible(param1);
      }
      
      public function as_setShorcutLabel(param1:String) : void
      {
      }
      
      public function as_showGrid(param1:Boolean) : void
      {
         this.entriesContainer.grid.visible = this.gridJacket.visible = param1;
         this.simpleJacket.visible = !param1;
         invalidateSize();
      }
      
      public function as_setGrid(param1:int, param2:int) : void
      {
         this.gridJacket.setGrid(param1,param2);
         this.entriesContainer.grid.setGrid(param1,param2);
      }
      
      override public function as_setBackground(param1:String) : void
      {
         this.entriesContainer.setBackground(param1);
      }
      
      override public function as_setAlpha(param1:Number) : void
      {
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
         {
            _loc2_ = this.entriesContainer.getMousePosition();
            onMinimapClicked(PveMinimapConst.MINIMAL_SIZE * _loc2_.x,PveMinimapConst.MINIMAL_SIZE * _loc2_.y,MouseEventEx(param1).buttonIdx,PveFullMapConst.DEFAULT_MAP_SIZE_INDEX);
         }
      }
      
      public function get dimmer() : Sprite
      {
         return this._dimmer;
      }
   }
}
