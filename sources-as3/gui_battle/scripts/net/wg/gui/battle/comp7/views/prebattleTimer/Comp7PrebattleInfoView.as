package net.wg.gui.battle.comp7.views.prebattleTimer
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.battle.comp7.views.prebattleTimer.events.Comp7PrebattleInfoViewEvent;
   import net.wg.gui.battle.views.prebattleInfo.PrebattleInfoViewBase;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.utils.IUniversalBtnStyles;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.events.ButtonEvent;
   
   public class Comp7PrebattleInfoView extends PrebattleInfoViewBase
   {
       
      
      public var readyBtn:UniversalBtn = null;
      
      public var glowMc:MovieClip = null;
      
      private var _data:Comp7PrebattleInfoViewVO = null;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _uniBtnStyles:IUniversalBtnStyles;
      
      public function Comp7PrebattleInfoView()
      {
         this._uniBtnStyles = App.utils.universalBtnStyles;
         super();
      }
      
      override public function updateStage(param1:int, param2:int) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._stageWidth = App.appWidth;
         this._stageHeight = App.appHeight;
         hintContainer.mouseEnabled = false;
         hintContainer.mouseChildren = false;
         bg.mouseEnabled = false;
         bg.mouseChildren = false;
         this.glowMc.mouseEnabled = this.glowMc.mouseChildren = false;
         App.utils.commons.addEmptyHitArea(this.glowMc);
         this.readyBtn.addEventListener(ButtonEvent.CLICK,this.onReadyBtnClickHandler);
         this._uniBtnStyles.setStyle(this.readyBtn,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
      }
      
      override protected function updateData(param1:Boolean) : void
      {
         this.readyBtn.label = this._data.readyBtnLabel;
         this.readyBtn.tooltip = this._data.readyBtnTooltip;
      }
      
      override protected function prepareData(param1:Object) : void
      {
         this._data = new Comp7PrebattleInfoViewVO(param1);
      }
      
      override protected function isSmallState() : Boolean
      {
         return this._stageWidth < StageSizeBoundaries.WIDTH_1920 || this._stageHeight < StageSizeBoundaries.HEIGHT_1080;
      }
      
      override protected function onDispose() : void
      {
         this.readyBtn.removeEventListener(ButtonEvent.CLICK,this.onReadyBtnClickHandler);
         this.readyBtn.dispose();
         this.readyBtn = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this._uniBtnStyles = null;
         this.glowMc.hitArea = null;
         this.glowMc = null;
         super.onDispose();
      }
      
      private function onReadyBtnClickHandler(param1:Event) : void
      {
         dispatchEvent(new Comp7PrebattleInfoViewEvent(Comp7PrebattleInfoViewEvent.READY_BTN_CLICKED));
      }
   }
}
