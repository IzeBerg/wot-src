package net.wg.gui.lobby.missions.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.lobby.missions.data.MissionPackMarathonBodyVO;
   import net.wg.gui.lobby.missions.interfaces.IMissionPackBody;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class MissionPackMarathonBody extends UIComponentEx implements IMissionPackBody
   {
      
      private static const RENDERER_WIDTH:int = 482;
      
      private static const RENDERER_HEIGHT:int = 222;
      
      private static const RENDERERS_HORIZONTAL_GAP_MIN:int = 10;
      
      private static const RENDERERS_HORIZONTAL_GAP_MAX:int = 22;
      
      private static const RENDERERS_VERTICAL_GAP_MIN:int = 10;
      
      private static const RENDERERS_VERTICAL_GAP_MAX:int = 22;
      
      private static const FULL_TWEEN_DURATION:int = 300;
      
      protected static const LIST_PADDING_BOTTOM_MIN:int = 25;
      
      private static const DUMMY_HEIGHT:int = 160;
       
      
      public var missionsList:SimpleTileList;
      
      public var dummy:IDummy;
      
      public var maskMc:Sprite;
      
      private var _visibleMaskPart:Number = 1;
      
      private var _tween:Tween;
      
      private var _collapsed:Boolean = false;
      
      private var _large:Boolean = false;
      
      public function MissionPackMarathonBody()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
         this.setItemRenderer();
         this.missionsList.directionMode = DirectionMode.HORIZONTAL;
         this.missionsList.tileWidth = RENDERER_WIDTH;
         this.missionsList.tileHeight = RENDERER_HEIGHT;
         this.missionsList.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         this.missionsList.addEventListener(Event.RESIZE,this.onListResizeHandler);
         this.dummy.height = DUMMY_HEIGHT;
      }
      
      protected function setItemRenderer() : void
      {
         this.missionsList.itemRenderer = App.utils.classFactory.getClass(QUESTS_ALIASES.MISSION_CARD_RENDERER_LINKAGE);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateContentWidth();
         }
      }
      
      override protected function onDispose() : void
      {
         this.missionsList.removeEventListener(Event.RESIZE,this.onListResizeHandler);
         this.missionsList.dispose();
         this.missionsList = null;
         this.dummy.dispose();
         this.dummy = null;
         this.maskMc = null;
         this.removeTween();
         super.onDispose();
      }
      
      public function setCollapsed(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._collapsed == param1)
         {
            return;
         }
         this._collapsed = param1;
         if(param2)
         {
            this.removeTween();
            visible = true;
            _loc3_ = !!this._collapsed ? int(0) : int(1);
            _loc4_ = FULL_TWEEN_DURATION * Math.abs(_loc3_ - this._visibleMaskPart) | 0;
            this._tween = new Tween(_loc4_,this,{"visibleMaskPart":_loc3_});
            this._tween.onComplete = this.onAnimComplete;
         }
         else
         {
            this.onAnimComplete();
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            _loc2_ = param1;
            _loc3_ = _loc2_.dummy != null;
            if(_loc3_)
            {
               this.dummy.setData(_loc2_.dummy);
               this.missionsList.dataProvider = null;
            }
            else
            {
               this.missionsList.dataProvider = _loc2_.missionsDataProvider;
            }
            this.dummy.visible = _loc3_;
            this.missionsList.visible = !_loc3_;
            this.updateContentWidth();
            this.missionsList.validateNow();
         }
      }
      
      protected function get dataClass() : Class
      {
         return MissionPackMarathonBodyVO;
      }
      
      private function removeTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onAnimComplete() : void
      {
         this.visibleMaskPart = !!this._collapsed ? Number(0) : Number(1);
         visible = !this._collapsed;
         this.removeTween();
      }
      
      protected function updateContentWidth() : void
      {
         this.maskMc.width = _width;
         if(this.dummy.visible)
         {
            this.dummy.width = _width;
         }
         else
         {
            this._large = _width >= MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_LARGE;
            this.missionsList.horizontalGap = !!this._large ? Number(RENDERERS_HORIZONTAL_GAP_MAX) : Number(RENDERERS_HORIZONTAL_GAP_MIN);
            this.missionsList.verticalGap = !!this._large ? Number(RENDERERS_VERTICAL_GAP_MAX) : Number(RENDERERS_VERTICAL_GAP_MIN);
            this.missionsList.width = _width;
         }
      }
      
      private function updateVisibleMaskHeight() : void
      {
         this.maskMc.height = this._visibleMaskPart * this.getContentHeight();
         alpha = this._visibleMaskPart;
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      protected function isBigWidth() : Boolean
      {
         return this._large;
      }
      
      protected function getContentHeight() : int
      {
         return !!this.dummy.visible ? int(this.dummy.height) : int(this.missionsList.height + LIST_PADDING_BOTTOM_MIN);
      }
      
      override public function get height() : Number
      {
         return this.maskMc.height;
      }
      
      public function get visibleMaskPart() : Number
      {
         return this._visibleMaskPart;
      }
      
      public function set visibleMaskPart(param1:Number) : void
      {
         if(this._visibleMaskPart == param1)
         {
            return;
         }
         this._visibleMaskPart = param1;
         this.updateVisibleMaskHeight();
      }
      
      private function onListResizeHandler(param1:Event) : void
      {
         this.updateVisibleMaskHeight();
      }
   }
}
