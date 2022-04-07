package net.wg.gui.lobby.profile.pages.technique
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
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
       
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var scrollBar:ScrollBar = null;
      
      private var _data:ProfileVehicleDossierVO = null;
      
      private var _isDataInitialized:Boolean = false;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _group:TechDetailedUnitGroup = null;
      
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
         this.scrollBar.removeEventListener(Event.RESIZE,this.onScrollBarResizeHandler);
         this._tweenManager.dispose();
         this._tweenManager = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:VerticalGroupLayout = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            if(!this._isDataInitialized)
            {
               this._isDataInitialized = true;
               this._group = new TechDetailedUnitGroup();
               this._group.unitRendererLinkage = Linkages.STATISTICS_DASH_LINE_TEXT_ITEM_RENDERER;
               _loc1_ = new VerticalGroupLayout();
               _loc1_.gap = LAYOUT_GAP;
               this._group.layout = _loc1_;
               this._group.x = GROUP_X;
               Sprite(this.scrollPane.target).addChild(this._group);
               this._tweenManager.registerAndLaunch(ANIM_SPEED,this,{"alpha":DEST_ALPHA},{
                  "ease":Strong.easeOut,
                  "onComplete":this.onTweenComplete
               });
            }
            this._group.dataProvider = this._data.detailedDataList;
            this.scrollPane.visible = true;
            if(currentDimension)
            {
               invalidateSize();
            }
         }
         if(currentDimension != null && isInvalid(InvalidationType.SIZE))
         {
            this.scrollPane.setSize(currentDimension.x - this.scrollPane.x,currentDimension.y - this.scrollPane.y);
            this.scrollBar.height = this.scrollPane.height - SB_MARGIN - SB_MARGIN;
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
   }
}
