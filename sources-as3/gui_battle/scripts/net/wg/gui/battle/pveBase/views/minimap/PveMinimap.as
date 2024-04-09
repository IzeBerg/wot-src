package net.wg.gui.battle.pveBase.views.minimap
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.PveMinimapBaseJacket;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.PveMinimapGridJacket;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.PveMinimapSimpleJacket;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.infrastructure.base.meta.IPveMinimapMeta;
   import net.wg.infrastructure.base.meta.impl.PveMinimapMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.MouseEventEx;
   
   public class PveMinimap extends PveMinimapMeta implements IPveMinimapMeta
   {
      
      private static const SHORTCUT_LABEL_OFFSET:int = 8;
      
      private static const MESSAGE_COORDINATE_OFFSET:int = -8;
       
      
      public var simpleJacket:PveMinimapSimpleJacket = null;
      
      public var gridJacket:PveMinimapGridJacket = null;
      
      public var mapHit:MovieClip = null;
      
      public var mapShortcutLabel:PveMinimapShortcutLabel = null;
      
      public var entriesContainer:PveMinimapEntriesContainer = null;
      
      private var _currentJacket:PveMinimapBaseJacket = null;
      
      private var _clickAreaSpr:Sprite = null;
      
      private var _updateSizeIndexForce:Boolean = false;
      
      private var _currentSizeIndex:int = 0;
      
      public function PveMinimap()
      {
         super();
         messageCoordinateOffset = MESSAGE_COORDINATE_OFFSET;
         this.gridJacket.setEntriesContainer(this.entriesContainer);
         this._clickAreaSpr = new Sprite();
         addChildAt(this._clickAreaSpr,getChildIndex(this.mapHit));
         this.mapHit.visible = true;
         this._clickAreaSpr.hitArea = this.mapHit;
         if(this.mapShortcutLabel != null)
         {
            this.mapShortcutLabel.x = -this.mapShortcutLabel.width - SHORTCUT_LABEL_OFFSET | 0;
            this.mapShortcutLabel.y = SHORTCUT_LABEL_OFFSET;
         }
         this.setJacket(this.gridJacket);
      }
      
      override public function as_setBackground(param1:String) : void
      {
         this.entriesContainer.setBackground(param1);
      }
      
      override public function as_setSize(param1:int) : void
      {
         if(!initialized)
         {
            this._currentSizeIndex = param1;
         }
         else
         {
            this.checkNewSize(param1);
         }
      }
      
      override public function getMinimapRectBySizeIndex(param1:int) : Rectangle
      {
         var _loc2_:int = this._currentSizeIndex;
         if(param1 >= 0 && param1 < MinimapSizeConst.MAP_SIZE.length)
         {
            _loc2_ = param1;
         }
         return new Rectangle(0,0,MinimapSizeConst.MAP_SIZE[_loc2_].width + this._currentJacket.horizontalGap,MinimapSizeConst.MAP_SIZE[_loc2_].height + this._currentJacket.verticalGap);
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible)
         {
            return null;
         }
         return new <Rectangle>[this.mapHit.getBounds(App.stage)];
      }
      
      override public function setAllowedSizeIndex(param1:Number) : void
      {
         if((this._currentSizeIndex != param1 || this._updateSizeIndexForce) && initialized)
         {
            this._currentSizeIndex = param1;
            dispatchEvent(new MinimapEvent(MinimapEvent.SIZE_CHANGED));
            this.updateContainersSize();
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
            applyNewSizeS(param1);
         }
         else
         {
            this._currentSizeIndex = param1;
         }
         this._updateSizeIndexForce = false;
      }
      
      override public function updateSizeIndex(param1:Boolean) : void
      {
         this._updateSizeIndexForce = param1;
         this.checkNewSize(this._currentSizeIndex);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._updateSizeIndexForce = true;
         this.checkNewSize(this._currentSizeIndex);
      }
      
      override protected function onDispose() : void
      {
         this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._clickAreaSpr = null;
         this.mapHit = null;
         this.mapShortcutLabel.dispose();
         this.mapShortcutLabel = null;
         this.entriesContainer.dispose();
         this.entriesContainer = null;
         this.simpleJacket.dispose();
         this.simpleJacket = null;
         this.gridJacket.dispose();
         this.gridJacket = null;
         super.onDispose();
      }
      
      private function updateContainersSize() : void
      {
         var _loc1_:Rectangle = MinimapSizeConst.MAP_SIZE[this._currentSizeIndex];
         this.entriesContainer.setSize(_loc1_.width,_loc1_.height);
         this.mapHit.width = _loc1_.width;
         this.mapHit.height = _loc1_.height;
         this._currentJacket.setSize(this._currentSizeIndex);
         this.mapHit.x = this.entriesContainer.x = this._currentJacket.leftGap;
         this.mapHit.y = this.entriesContainer.y = this._currentJacket.topGap;
         MinimapEntryController.instance.updateScale(this._currentSizeIndex,this);
      }
      
      private function setJacket(param1:PveMinimapBaseJacket) : void
      {
         if(this._currentJacket == param1)
         {
            return;
         }
         if(this._currentJacket != null)
         {
            this._currentJacket.visible = false;
         }
         this._currentJacket = param1;
         if(param1 != null)
         {
            param1.visible = true;
            param1.setSize(this._currentSizeIndex);
            this.updateContainersSize();
            dispatchEvent(new MinimapEvent(MinimapEvent.SIZE_CHANGED));
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
         }
      }
      
      private function checkNewSize(param1:int) : void
      {
         dispatchEvent(new MinimapEvent(MinimapEvent.TRY_SIZE_CHANGED,false,false,param1));
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible == param1)
         {
            return;
         }
         super.visible = param1;
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
      }
      
      override public function get currentWidth() : int
      {
         return MinimapSizeConst.MAP_SIZE[this._currentSizeIndex].width + this._currentJacket.horizontalGap;
      }
      
      override public function get currentHeight() : int
      {
         return MinimapSizeConst.MAP_SIZE[this._currentSizeIndex].height + this._currentJacket.verticalGap;
      }
      
      override public function get currentSizeIndex() : Number
      {
         return this._currentSizeIndex;
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
         {
            _loc2_ = this.entriesContainer.getMousePosition();
            onMinimapClicked(PveMinimapConst.MINIMAL_SIZE * _loc2_.x,PveMinimapConst.MINIMAL_SIZE * _loc2_.y,MouseEventEx(param1).buttonIdx,this._currentSizeIndex);
         }
      }
      
      public function as_setShorcutLabel(param1:String) : void
      {
         if(this.mapShortcutLabel != null)
         {
            this.mapShortcutLabel.setText(param1);
            this.mapShortcutLabel.x = -this.mapShortcutLabel.width - SHORTCUT_LABEL_OFFSET | 0;
            this.mapShortcutLabel.visible = !StringUtils.isEmpty(param1);
         }
      }
      
      public function as_showGrid(param1:Boolean) : void
      {
         if(param1)
         {
            this.setJacket(this.gridJacket);
         }
         else
         {
            this.setJacket(this.simpleJacket);
         }
      }
      
      public function as_setGrid(param1:int, param2:int) : void
      {
         this.gridJacket.setGrid(param1,param2);
         this.entriesContainer.grid.setGrid(param1,param2);
      }
      
      override public function as_setScenarioEvent(param1:String, param2:String, param3:String) : void
      {
         this.entriesContainer.scenarioLayer.setScenarioEvent(param1,param2,param3);
      }
      
      override public function as_clearScenarioEvent(param1:String) : void
      {
         this.entriesContainer.scenarioLayer.clearScenarioEvent(param1);
      }
      
      override public function as_setScenarioEventVisible(param1:String, param2:Boolean) : void
      {
         this.entriesContainer.scenarioLayer.setScenarioEventVisible(param1,param2);
      }
   }
}
