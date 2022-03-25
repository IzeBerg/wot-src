package net.wg.gui.battle.views.minimap
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class Minimap extends BaseMinimap
   {
      
      private static const OPTIMIZE_OFFSET:int = 10;
      
      private static const ANIM_FADE_IN:String = "fadeIn";
      
      private static const ANIM_FADE_OUT:String = "fadeOut";
       
      
      public var mouseBlockMC:Sprite = null;
      
      public var mapHit:Sprite = null;
      
      public var fakePixel:MovieClip = null;
      
      public var foreground0:BattleAtlasSprite = null;
      
      public var foreground1:BattleAtlasSprite = null;
      
      public var foreground2:BattleAtlasSprite = null;
      
      public var foreground3:BattleAtlasSprite = null;
      
      public var foreground4:BattleAtlasSprite = null;
      
      public var foreground5:BattleAtlasSprite = null;
      
      public var entriesContainerMask:Sprite = null;
      
      public var entriesContainer:MinimapEntriesContainer = null;
      
      public var background:UILoaderAlt = null;
      
      public var minimapHint:MinimapHint = null;
      
      private var _foregrounds:Vector.<Sprite> = null;
      
      private var _currForeground:Sprite = null;
      
      private var _currentSizeIndex:int = 0;
      
      private var _updateSizeIndexForce:Boolean = false;
      
      private var _clickAreaSpr:Sprite = null;
      
      private var _bIsHintPanelEnabled:Boolean = false;
      
      public function Minimap()
      {
         super();
         mouseEnabled = false;
         this._foregrounds = new <Sprite>[this.foreground0,this.foreground1,this.foreground2,this.foreground3,this.foreground4,this.foreground5];
         this.foreground0.imageName = BATTLEATLAS.MINIMAP_B1;
         this.foreground1.imageName = BATTLEATLAS.MINIMAP_B2;
         this.foreground2.imageName = BATTLEATLAS.MINIMAP_B3;
         this.foreground3.imageName = BATTLEATLAS.MINIMAP_B4;
         this.foreground4.imageName = BATTLEATLAS.MINIMAP_B5;
         this.foreground5.imageName = BATTLEATLAS.MINIMAP_B6;
         this.foreground0.visible = this.foreground1.visible = this.foreground2.visible = this.foreground3.visible = this.foreground4.visible = this.foreground5.visible = false;
         this._currForeground = this.foreground0;
         this.updateCursorBlock();
         this.entriesContainer.mask = this.entriesContainerMask;
         this._clickAreaSpr = new Sprite();
         addChildAt(this._clickAreaSpr,getChildIndex(this.mapHit));
         this.mapHit.visible = false;
         this._clickAreaSpr.hitArea = this.mapHit;
         this.mouseBlockMC.hitArea = this.mouseBlockMC;
         removeChild(this.fakePixel);
         this.fakePixel = null;
         this.updateIntenalHintPanelData(false,false);
         this.minimapHint.gotoAndStop(ANIM_FADE_IN);
      }
      
      public function onButtonClick(param1:Object) : void
      {
         var _loc2_:* = param1.name;
         switch(false ? 0 : 0)
         {
         }
      }
      
      override public function as_setAlpha(param1:Number) : void
      {
         alpha = param1;
      }
      
      override public function as_setBackground(param1:String) : void
      {
         this.background.source = param1;
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
      
      override public function as_enableHintPanelWithData(param1:Boolean, param2:Boolean) : void
      {
         this.updateIntenalHintPanelData(param1,param2);
         this._bIsHintPanelEnabled = true;
         this.minimapHint.gotoAndPlay(ANIM_FADE_IN);
      }
      
      override public function as_disableHintPanel() : void
      {
         this._bIsHintPanelEnabled = false;
         this.minimapHint.gotoAndPlay(ANIM_FADE_OUT);
      }
      
      override public function as_updateHintPanelData(param1:Boolean, param2:Boolean) : void
      {
         this.updateIntenalHintPanelData(param1,param2);
      }
      
      override public function as_setVisible(param1:Boolean) : void
      {
         this.visible = param1;
         dispatchEvent(new MinimapEvent(MinimapEvent.VISIBILITY_CHANGED));
      }
      
      override public function getMessageCoordinate() : Number
      {
         return initedHeight - this.currentTopLeftPoint.y;
      }
      
      override public function getMinimapRectBySizeIndex(param1:int) : Rectangle
      {
         var _loc2_:int = this._currentSizeIndex;
         if(param1 >= 0 && param1 < MinimapSizeConst.MAP_SIZE.length)
         {
            _loc2_ = param1;
         }
         return new Rectangle(0,0,initedWidth - MinimapSizeConst.MAP_SIZE[_loc2_].x,initedHeight - MinimapSizeConst.MAP_SIZE[_loc2_].y);
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible)
         {
            return null;
         }
         var _loc1_:Rectangle = this._currForeground.getBounds(App.stage);
         _loc1_.x += OPTIMIZE_OFFSET;
         _loc1_.y += OPTIMIZE_OFFSET;
         _loc1_.width -= OPTIMIZE_OFFSET;
         _loc1_.height -= OPTIMIZE_OFFSET;
         return new <Rectangle>[_loc1_];
      }
      
      override public function setAllowedSizeIndex(param1:Number) : void
      {
         if((this._currentSizeIndex != param1 || this._updateSizeIndexForce) && initialized)
         {
            this._currentSizeIndex = param1;
            dispatchEvent(new MinimapEvent(MinimapEvent.SIZE_CHANGED));
            this.updateContent();
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
         this.updateSizeIndex(true);
         this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._clickAreaSpr.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this._clickAreaSpr.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.mouseBlockMC.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.mouseBlockMC.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.foreground0 = null;
         this.foreground1 = null;
         this.foreground2 = null;
         this.foreground3 = null;
         this.foreground4 = null;
         this.foreground5 = null;
         this._currForeground = null;
         if(this._foregrounds)
         {
            this._foregrounds.fixed = false;
            this._foregrounds.splice(0,this._foregrounds.length);
            this._foregrounds = null;
         }
         this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._clickAreaSpr = null;
         this.entriesContainer.dispose();
         this.entriesContainer = null;
         this.entriesContainerMask = null;
         this.mapHit = null;
         this.background.dispose();
         this.background = null;
         this.minimapHint.dispose();
         this.minimapHint = null;
         super.onDispose();
      }
      
      private function updateContent() : void
      {
         this._currForeground.visible = false;
         this._currForeground = this._foregrounds[this._currentSizeIndex];
         this._currForeground.visible = true;
         this.updateContainersSize();
         this.updateCursorBlock();
      }
      
      private function updateContainersSize() : void
      {
         var _loc1_:Rectangle = MinimapSizeConst.MAP_SIZE[this._currentSizeIndex];
         this.background.width = _loc1_.width;
         this.background.height = _loc1_.height;
         this.background.x = _loc1_.x;
         this.background.y = _loc1_.y;
         var _loc2_:Point = MinimapSizeConst.ENTRY_CONTAINER_POINT[this._currentSizeIndex];
         this.entriesContainer.scaleX = this.background.scaleX;
         this.entriesContainer.scaleY = this.background.scaleY;
         MinimapEntryController.instance.updateScale(this._currentSizeIndex);
         this.entriesContainer.x = _loc2_.x;
         this.entriesContainer.y = _loc2_.y;
         this.entriesContainerMask.width = _loc1_.width;
         this.entriesContainerMask.height = _loc1_.height;
         this.entriesContainerMask.x = _loc2_.x;
         this.entriesContainerMask.y = _loc2_.y;
         this.mapHit.width = _loc1_.width;
         this.mapHit.height = _loc1_.height;
         this.mapHit.x = _loc1_.x;
         this.mapHit.y = _loc1_.y;
         this.minimapHint.x = _loc1_.x;
         this.minimapHint.y = _loc1_.y;
      }
      
      private function checkNewSize(param1:int) : void
      {
         dispatchEvent(new MinimapEvent(MinimapEvent.TRY_SIZE_CHANGED,false,false,param1));
      }
      
      private function updateIntenalHintPanelData(param1:Boolean, param2:Boolean) : void
      {
         this.minimapHint.setLeftMinimapHintIconType(MinimapIconCollection.ICON_ATTENTION);
         if(param2)
         {
            this.minimapHint.setRightMinimapHintIconType(MinimapIconCollection.ICON_REPOSITION_VIEW);
            if(param1)
            {
               this.minimapHint.setLeftMinimapHintIconType(MinimapIconCollection.ICON_SPG);
            }
            return;
         }
         this.minimapHint.setRightMinimapHintIconType(MinimapIconCollection.ICON_WAYPOINT);
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
      
      override public function get currentTopLeftPoint() : Point
      {
         var _loc1_:Rectangle = MinimapSizeConst.MAP_SIZE[this._currentSizeIndex];
         return _loc1_.topLeft;
      }
      
      override public function get currentSizeIndex() : Number
      {
         return this._currentSizeIndex;
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
         {
            onMinimapClickedS(this.mapHit.mouseX,this.mapHit.mouseY,MouseEventEx(param1).buttonIdx,this._currentSizeIndex);
         }
      }
      
      override public function onEntryMouseClickEvent(param1:MouseEvent, param2:Number, param3:Number) : void
      {
         onMinimapClickedS(this.mapHit.mouseX,this.mapHit.mouseY,MouseEventEx(param1).buttonIdx,this._currentSizeIndex);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr || param1.target == this.mouseBlockMC)
         {
            if(this._bIsHintPanelEnabled)
            {
               this.minimapHint.gotoAndPlay(ANIM_FADE_OUT);
            }
            handleMouseOverUIMinimap(true);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr || param1.target == this.mouseBlockMC)
         {
            if(this._bIsHintPanelEnabled)
            {
               this.minimapHint.gotoAndPlay(ANIM_FADE_IN);
            }
            handleMouseOverUIMinimap(false);
         }
      }
      
      private function updateCursorBlock() : void
      {
         this.mouseBlockMC.x = this._currForeground.x;
         this.mouseBlockMC.y = this._currForeground.y;
         this.mouseBlockMC.width = this._currForeground.width;
         this.mouseBlockMC.height = this._currForeground.height;
      }
   }
}
