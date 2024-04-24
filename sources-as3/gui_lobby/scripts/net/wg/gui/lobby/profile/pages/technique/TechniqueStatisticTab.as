package net.wg.gui.lobby.profile.pages.technique
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.profile.components.ResizableContent;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class TechniqueStatisticTab extends ResizableContent
   {
      
      private static const SB_MARGIN:Number = 10;
      
      private static const ANIM_SPEED:Number = 500;
      
      private static const LAYOUT_GAP:Number = 10;
      
      private static const GROUP_X:Number = 21;
      
      private static const INIT_ALPHA:Number = 0;
      
      private static const DEST_ALPHA:Number = 1;
      
      private static const DEFAULT_GROUP_Y:uint = 0;
      
      private static const PRESTIGE_WIDTH:uint = 375;
      
      private static const PRESTIGE_HEIGHT:uint = 150;
      
      private static const PRESTIGE_X:uint = 13;
      
      private static const PRESTIGE_Y_OFFSET:uint = 2;
      
      private static const PRESTIGE_WIDGET_NAME:String = "prestigeWidget";
      
      private static const PRESTIGE_BG_X:int = -46;
      
      private static const PRESTIGE_BG_Y:int = -42;
      
      private static const PRESTIGE_BG_NAME:String = "prestigeBg";
      
      private static const INVALIDATE_PRESTIGE_VISIBILITY:String = "invPrestigeVisibility";
       
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var scrollPanelTopLine:Sprite = null;
      
      private var _data:ProfileVehicleDossierVO = null;
      
      private var _isDataInitialized:Boolean = false;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _group:TechDetailedUnitGroup = null;
      
      private var _prestigeProgressInject:GFInjectComponent = null;
      
      private var _prestigeBg:UILoaderAlt = null;
      
      private var _isPrestigeAvailable:Boolean = false;
      
      public function TechniqueStatisticTab()
      {
         this._tweenManager = new ExcludeTweenManager();
         super();
      }
      
      override public function applyResizing() : void
      {
         super.applyResizing();
         invalidateSize();
      }
      
      override public function update(param1:Object) : void
      {
         var _loc2_:ProfileVehicleDossierVO = ProfileVehicleDossierVO(param1);
         if(this._data != _loc2_)
         {
            this._data = _loc2_;
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         alpha = INIT_ALPHA;
         this.scrollPane.visible = false;
         this.scrollBar.visible = false;
         this.scrollPane.scrollBarMargin = SB_MARGIN;
         this.scrollPane.scrollBar = this.scrollBar;
         this.scrollBar.addEventListener(Event.RESIZE,this.onScrollBarResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         if(this._group != null)
         {
            this._group.dispose();
            this._group = null;
         }
         this.removePrestigeWidget();
         this.scrollBar.removeEventListener(Event.RESIZE,this.onScrollBarResizeHandler);
         this._tweenManager.dispose();
         this._tweenManager = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.scrollPanelTopLine = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:VerticalGroupLayout = null;
         super.draw();
         if(this._data != null)
         {
            _loc1_ = isInvalid(INVALIDATE_PRESTIGE_VISIBILITY);
            _loc2_ = isInvalid(InvalidationType.DATA);
            if(_loc1_)
            {
               if(this._prestigeProgressInject == null && this._isPrestigeAvailable)
               {
                  this.addPrestigeWidget();
               }
               else if(this._prestigeProgressInject && !this._isPrestigeAvailable)
               {
                  this.removePrestigeWidget();
                  invalidateLayout();
               }
            }
            if(_loc2_)
            {
               if(!this._isDataInitialized)
               {
                  this._isDataInitialized = true;
                  this._group = new TechDetailedUnitGroup();
                  this._group.unitRendererLinkage = Linkages.STATISTICS_DASH_LINE_TEXT_ITEM_RENDERER;
                  _loc3_ = new VerticalGroupLayout();
                  _loc3_.gap = LAYOUT_GAP;
                  this._group.layout = _loc3_;
                  this._group.x = GROUP_X;
                  (this.scrollPane.target as Sprite).addChild(this._group);
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this,{"alpha":DEST_ALPHA},{
                     "ease":Strong.easeOut,
                     "onComplete":this.onTweenComplete
                  });
                  invalidateLayout();
               }
               this._group.dataProvider = this._data.detailedDataList;
               this.scrollPane.visible = true;
            }
            if((_loc1_ || _loc2_) && currentDimension)
            {
               invalidateSize();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this._group.y = Boolean(this._prestigeProgressInject) ? Number(PRESTIGE_HEIGHT) : Number(DEFAULT_GROUP_Y);
            }
         }
         if(currentDimension != null && isInvalid(InvalidationType.SIZE))
         {
            this.scrollPane.setSize(currentDimension.x - this.scrollPane.x,currentDimension.y - this.scrollPane.y);
            this.scrollBar.height = this.scrollPane.height - SB_MARGIN - SB_MARGIN;
         }
      }
      
      public function updatePrestigeVisibility(param1:Boolean) : void
      {
         if(param1 != this._isPrestigeAvailable)
         {
            this._isPrestigeAvailable = param1;
            invalidate(INVALIDATE_PRESTIGE_VISIBILITY);
         }
      }
      
      private function addPrestigeWidget() : void
      {
         var _loc1_:Sprite = null;
         if(!this._prestigeProgressInject)
         {
            _loc1_ = this.scrollPane.target as Sprite;
            this._prestigeProgressInject = new GFInjectComponent();
            this._prestigeProgressInject.name = PRESTIGE_WIDGET_NAME;
            this._prestigeProgressInject.setManageSize(true);
            this._prestigeProgressInject.width = PRESTIGE_WIDTH + 2 * PRESTIGE_Y_OFFSET;
            this._prestigeProgressInject.height = PRESTIGE_HEIGHT + 2 * PRESTIGE_Y_OFFSET;
            this._prestigeProgressInject.x = PRESTIGE_X;
            this._prestigeProgressInject.y = -PRESTIGE_Y_OFFSET;
            _loc1_.addChild(this._prestigeProgressInject);
            this._prestigeProgressInject.dispatchEvent(new Event(Event.RESIZE,true));
            dispatchEvent(new ProfileTechniqueEvent(ProfileTechniqueEvent.PRESTIGE_WIDGET_ENABLED,true));
            this._prestigeBg = new UILoaderAlt();
            this._prestigeBg.name = PRESTIGE_BG_NAME;
            this._prestigeBg.autoSize = false;
            this._prestigeBg.x = PRESTIGE_BG_X;
            this._prestigeBg.y = PRESTIGE_BG_Y;
            _loc1_.addChildAt(this._prestigeBg,0);
            this._prestigeBg.addEventListener(UILoaderEvent.COMPLETE,this.onBackgroundLoadCompleteHandler);
            this._prestigeBg.source = RES_ICONS.MAPS_ICONS_PRESTIGE_VEHICLESTATISTICSVIEW_BG;
            invalidateLayout();
         }
      }
      
      private function removePrestigeWidget() : void
      {
         if(isDisposed())
         {
            return;
         }
         var _loc1_:Sprite = this.scrollPane.target as Sprite;
         if(this._prestigeProgressInject)
         {
            this._prestigeProgressInject.dispatchEvent(new Event(Event.RESIZE,true));
            _loc1_.removeChild(this._prestigeProgressInject);
            this._prestigeProgressInject = null;
            dispatchEvent(new ProfileTechniqueEvent(ProfileTechniqueEvent.PRESTIGE_WIDGET_DISABLED,true));
         }
         if(this._prestigeBg)
         {
            _loc1_.removeChild(this._prestigeBg);
            this._prestigeBg.removeEventListener(UILoaderEvent.COMPLETE,this.onBackgroundLoadCompleteHandler);
            this._prestigeBg.dispose();
            this._prestigeBg = null;
         }
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this._tweenManager.unregister(param1);
         invalidateSize();
      }
      
      private function onScrollBarResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onBackgroundLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this._prestigeBg.removeEventListener(UILoaderEvent.COMPLETE,this.onBackgroundLoadCompleteHandler);
      }
      
      public function get prestigeWidget() : GFInjectComponent
      {
         return this._prestigeProgressInject;
      }
   }
}
