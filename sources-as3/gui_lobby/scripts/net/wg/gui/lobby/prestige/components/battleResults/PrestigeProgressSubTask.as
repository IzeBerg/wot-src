package net.wg.gui.lobby.prestige.components.battleResults
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.ProgressIndicatorStates;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.gui.lobby.prestige.components.common.PrestigeEmblem;
   import net.wg.gui.lobby.prestige.data.PrestigeProgressVO;
   import net.wg.gui.lobby.prestige.event.PrestigeEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PrestigeProgressSubTask extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const EMBLEM_NAME:String = "emblem";
      
      private static const EMBLEM_X:uint = 413;
      
      private static const EMBLEM_MAX_X:uint = 401;
      
      private static const EMBLEM_Y:uint = 6;
      
      private static const PROGRESS_DIFF_OFFSET_Y:uint = 14;
      
      private static const LINK_BTN_OFFSET:uint = 10;
      
      private static const BOTTOM_LINE_OFFSET:uint = 22;
       
      
      public var linkBtn:SoundButtonEx;
      
      public var title:TextField = null;
      
      public var descr:TextField = null;
      
      public var progressDiff:MovieClip = null;
      
      public var progressIndicator:ProgressIndicator = null;
      
      public var lineMC:MovieClip = null;
      
      private var _data:PrestigeProgressVO = null;
      
      private var _emblem:PrestigeEmblem = null;
      
      private var _showProgressDiffTooltip:Boolean = false;
      
      public function PrestigeProgressSubTask()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._emblem = new PrestigeEmblem();
         this._emblem.name = EMBLEM_NAME;
         this._emblem.y = EMBLEM_Y;
         addChild(this._emblem);
         this.title.text = BATTLE_RESULTS.PRESTIGE_TITLE;
         this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         this.progressDiff.addEventListener(MouseEvent.CLICK,this.onProgressDiffClickHandler);
         this.progressDiff.addEventListener(MouseEvent.ROLL_OUT,this.onProgressDiffRollOutHandler);
         this.progressDiff.addEventListener(MouseEvent.ROLL_OVER,this.onProgressDiffRollOverHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._emblem.setData(this._data.gradeType,this._data.grade,this._data.lvl);
               _loc1_ = this._emblem.isMaximumGrade;
               this._showProgressDiffTooltip = !_loc1_ && Boolean(this._data.gainedXP);
               this.progressIndicator.visible = this.progressDiff.visible = !_loc1_;
               if(_loc1_)
               {
                  this._emblem.size = PrestigeEmblem.SIZE_SMALL;
                  this.descr.text = BATTLE_RESULTS.PRESTIGE_MAX_DESCRIPTION;
               }
               else
               {
                  this.progressDiff.textField.text = this._data.gainedXP;
                  this._emblem.size = PrestigeEmblem.SIZE_EXTRA_SMALL;
                  this.progressIndicator.setValues(ProgressIndicatorStates.CURRENT,this._data.currentXP,this._data.nextLvlXP);
                  this.descr.text = BATTLE_RESULTS.PRESTIGE_COMMON_DESCRIPTION;
               }
               App.utils.commons.updateTextFieldSize(this.descr,false,true);
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this._emblem.x = !!this._emblem.isMaximumGrade ? Number(EMBLEM_MAX_X) : Number(EMBLEM_X);
               this.linkBtn.x = this.title.x + this.title.textWidth + LINK_BTN_OFFSET | 0;
               this.linkBtn.y = this.title.height + this.title.y - this.linkBtn.height | 0;
               this.progressDiff.y = this.progressIndicator.y - PROGRESS_DIFF_OFFSET_Y | 0;
               this.lineMC.y = this.descr.y + this.descr.textHeight + BOTTOM_LINE_OFFSET | 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         this.linkBtn.dispose();
         this.linkBtn = null;
         removeChild(this._emblem);
         this._emblem.dispose();
         this._emblem = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         this.title = null;
         this.descr = null;
         this.progressDiff.removeEventListener(MouseEvent.CLICK,this.onProgressDiffClickHandler);
         this.progressDiff.removeEventListener(MouseEvent.ROLL_OUT,this.onProgressDiffRollOutHandler);
         this.progressDiff.removeEventListener(MouseEvent.ROLL_OVER,this.onProgressDiffRollOverHandler);
         this.progressDiff = null;
         this.lineMC = null;
         this._data = null;
         super.onDispose();
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this._data = PrestigeProgressVO(param1);
         invalidateData();
      }
      
      private function onLinkBtnRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_PRESTIGEPROGRESS_LINKBTN);
      }
      
      private function onLinkBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         this.hideTooltip();
         dispatchEvent(new PrestigeEvent(PrestigeEvent.SHOW_TECHNIQUE_PROFILE,this._data.vehCD));
      }
      
      private function onProgressDiffClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onProgressDiffRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onProgressDiffRollOverHandler(param1:MouseEvent) : void
      {
         if(this._showProgressDiffTooltip)
         {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_PROGRESS_EARNEDINBATTLE);
         }
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function get height() : Number
      {
         return this.lineMC.y;
      }
   }
}
