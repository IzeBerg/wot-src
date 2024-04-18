package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.missions.data.MarathonHeaderAwardBlockVO;
   import net.wg.gui.lobby.missions.interfaces.IMarathonHeaderBlock;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class MarathonHeaderAwardBlock extends UIComponentEx implements IMarathonHeaderBlock
   {
      
      private static const RENDERER_WIDTH:int = 80;
      
      private static const RENDERER_HEIGHT:int = 80;
      
      private static const RENDERERS_HORIZONTAL_GAP:int = 15;
      
      private static const RENDERERS_VERTICAL_GAP:int = 15;
      
      private static const MAX_ROW_RENDERERS:int = 3;
      
      private static const LIST_START_Y:int = 32;
      
      private static const IMG_START_Y:int = 22;
      
      private static const IMG_HEIGHT:int = 110;
       
      
      public var title:TextField;
      
      public var awardsList:SimpleTileList;
      
      public var awardImg:UILoaderAlt;
      
      private var _data:MarathonHeaderAwardBlockVO;
      
      private var _hasAwardImg:Boolean = true;
      
      private var _contentHeight:int;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function MarathonHeaderAwardBlock()
      {
         super();
         this._toolTipMgr = App.toolTipMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.awardsList.itemRenderer = App.utils.classFactory.getClass(Linkages.AWARD_RENDERER);
         this.awardsList.tileWidth = RENDERER_WIDTH;
         this.awardsList.tileHeight = RENDERER_HEIGHT;
         this.awardsList.horizontalGap = RENDERERS_HORIZONTAL_GAP;
         this.awardsList.verticalGap = RENDERERS_VERTICAL_GAP;
         this.awardsList.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         this.awardsList.y = LIST_START_Y;
         this.awardImg.y = IMG_START_Y;
         this.awardImg.addEventListener(MouseEvent.ROLL_OVER,this.onAwardImgRollOverHandler);
         this.awardImg.addEventListener(MouseEvent.ROLL_OUT,this.onAwardImgRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            this._hasAwardImg = this._data.hasAwardImg();
            if(!this._hasAwardImg)
            {
               this.awardsList.dataProvider = this._data.awardsData;
               this.awardsList.validateNow();
            }
            else
            {
               this.awardImg.source = this._data.awardImgSource;
            }
            this.awardsList.visible = !this._hasAwardImg;
            this.awardImg.visible = this._hasAwardImg;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._hasAwardImg)
            {
               height = this._contentHeight = IMG_HEIGHT;
            }
            else
            {
               this._contentHeight = RENDERER_HEIGHT;
               if(this.awardsList.length > MAX_ROW_RENDERERS)
               {
                  this._contentHeight += RENDERER_HEIGHT + RENDERERS_VERTICAL_GAP;
               }
               _loc1_ = this.awardsList.y + this._contentHeight;
               if(height != _loc1_)
               {
                  height = _loc1_;
                  dispatchEvent(new Event(Event.RESIZE));
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.awardsList.dispose();
         this.awardsList = null;
         this.awardImg.removeEventListener(MouseEvent.ROLL_OVER,this.onAwardImgRollOverHandler);
         this.awardImg.removeEventListener(MouseEvent.ROLL_OUT,this.onAwardImgRollOutHandler);
         this.awardImg.dispose();
         this.awardImg = null;
         this.title = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setContentTopPadding(param1:int) : void
      {
         if(this._hasAwardImg)
         {
            this.awardImg.y = param1 + IMG_START_Y;
         }
         else
         {
            this.awardsList.y = param1 + LIST_START_Y;
         }
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = MarathonHeaderAwardBlockVO(param1);
            invalidateData();
         }
      }
      
      public function get contentHeight() : int
      {
         return this._contentHeight;
      }
      
      private function onAwardImgRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.awardImgTooltip.isSpecial)
         {
            this._toolTipMgr.showSpecial.apply(this,[this._data.awardImgTooltip.specialAlias,null].concat(this._data.awardImgTooltip.specialArgs));
         }
      }
      
      private function onAwardImgRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
