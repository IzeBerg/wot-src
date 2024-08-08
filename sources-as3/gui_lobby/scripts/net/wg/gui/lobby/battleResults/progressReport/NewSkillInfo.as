package net.wg.gui.lobby.battleResults.progressReport
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class NewSkillInfo extends UIComponent
   {
      
      private static const LINK_BTN_OFFSET:int = 7;
      
      private static const BONUS_BTN_INITIAL_OFFSET:int = 20;
      
      private static const BONUS_BTN_INNER_OFFSET:int = 18;
       
      
      protected var bonusButtons:Vector.<SoundButtonEx>;
      
      public var title:TextField;
      
      public var linkBtn:SoundButtonEx;
      
      private var _data:BattleResultUnlockItemVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _linkBtnHasListeners:Boolean = false;
      
      public function NewSkillInfo()
      {
         this.bonusButtons = new Vector.<SoundButtonEx>();
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         if(this._linkBtnHasListeners)
         {
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         }
         this.linkBtn.dispose();
         this.linkBtn = null;
         this.clearBonusButtons();
         this.bonusButtons = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this._tooltipMgr.hide();
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.linkBtn.focusable = false;
         this.linkBtn.mouseEnabledOnDisabled = true;
         this.linkBtn.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
         if(!this._linkBtnHasListeners)
         {
            this._linkBtnHasListeners = true;
            this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         }
      }
      
      public function setData(param1:BattleResultUnlockItemVO) : void
      {
         this._data = param1;
         this.title.text = this._data.title;
         App.utils.commons.moveDsiplObjToEndOfText(this.linkBtn,this.title,LINK_BTN_OFFSET);
         this.linkBtn.enabled = this._data.linkBtnEnabled;
         this.clearBonusButtons();
         if(this._data.bonusSkillsAmount)
         {
            this.createBonusButtons();
         }
      }
      
      private function createBonusButtons() : void
      {
         var _loc1_:SoundButtonEx = null;
         _loc1_ = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._data.bonusSkillsAmount)
         {
            _loc1_ = App.utils.classFactory.getComponent(Linkages.LINK_PLUS_BONUS,SoundButtonEx);
            _loc1_.x = this.linkBtn.x + BONUS_BTN_INITIAL_OFFSET + _loc2_ * BONUS_BTN_INNER_OFFSET;
            _loc1_.y = this.linkBtn.y;
            _loc1_.enabled = this._data.linkBtnEnabled;
            _loc1_.focusable = false;
            _loc1_.mouseEnabledOnDisabled = true;
            _loc1_.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
            _loc1_.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onBonusBtnRollOverHandler);
            this.bonusButtons.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function clearBonusButtons() : void
      {
         var _loc1_:SoundButtonEx = null;
         while(this.bonusButtons.length)
         {
            _loc1_ = this.bonusButtons.shift();
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onBonusBtnRollOverHandler);
            _loc1_.dispose();
            removeChild(_loc1_);
         }
      }
      
      private function onBtnRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onLinkBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.linkBtnEnabled)
         {
            this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.EMPTY_SKILL_GF,this._data.linkId);
         }
         else
         {
            this._tooltipMgr.show(TOOLTIPS.QUESTS_LINKBTN_CUSTOMIZATIONPROGRESSION_DISABLED);
         }
      }
      
      private function onBonusBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.linkBtnEnabled)
         {
            this._tooltipMgr.showComplex(TOOLTIPS.BATTLERESULTS_NEWSKILLUNLOCK_BONUS);
         }
         else
         {
            this._tooltipMgr.show(TOOLTIPS.QUESTS_LINKBTN_CUSTOMIZATIONPROGRESSION_DISABLED);
         }
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:String = this._data.linkEvent;
         dispatchEvent(new UnlockLinkEvent(_loc2_,this._data.linkId));
      }
   }
}
