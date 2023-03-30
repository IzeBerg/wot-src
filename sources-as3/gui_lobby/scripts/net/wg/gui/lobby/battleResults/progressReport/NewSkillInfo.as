package net.wg.gui.lobby.battleResults.progressReport
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class NewSkillInfo extends UIComponent
   {
      
      private static const LINK_BTN_OFFSET:int = 7;
       
      
      public var title:TextField;
      
      public var linkBtn:SoundButtonEx;
      
      private var _data:BattleResultUnlockItemVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isFreeSkill:Boolean = false;
      
      private var _linkBtnHasListeners:Boolean = false;
      
      public function NewSkillInfo()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         if(this._linkBtnHasListeners)
         {
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         }
         this.linkBtn.dispose();
         this.linkBtn = null;
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
            this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         }
      }
      
      public function setData(param1:BattleResultUnlockItemVO, param2:Boolean = false) : void
      {
         this._data = param1;
         this._isFreeSkill = param2;
         this.title.text = !!this._isFreeSkill ? this._data.freeSkillsTitle : this._data.title;
         App.utils.commons.moveDsiplObjToEndOfText(this.linkBtn,this.title,LINK_BTN_OFFSET);
         this.linkBtn.enabled = this._data.linkBtnEnabled;
      }
      
      private function onLinkBtnRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onLinkBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data.linkBtnEnabled)
         {
            this._tooltipMgr.show(TOOLTIPS.QUESTS_LINKBTN_CUSTOMIZATIONPROGRESSION_DISABLED);
         }
      }
      
      private function onLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:String = !!this._isFreeSkill ? this._data.freeSkillsLinkEvent : this._data.linkEvent;
         dispatchEvent(new UnlockLinkEvent(_loc2_,this._data.linkId));
      }
   }
}
