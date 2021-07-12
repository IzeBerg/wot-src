package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.battleResults.data.EfficiencyHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EfficiencyHeader extends UIComponentEx
   {
      
      private static const SUMM_ICON_NO_STUN_X:int = 32;
      
      private static const SUMM_ICON_STUN_X:int = 0;
       
      
      public var summKillTF:TextField;
      
      public var summDamageTF:TextField;
      
      public var summCritsTF:TextField;
      
      public var summArmorTF:TextField;
      
      public var summAssistTF:TextField;
      
      public var summSpottedTF:TextField;
      
      public var summStunTF:TextField;
      
      public var summIconMC:MovieClip;
      
      private var _headerVO:EfficiencyHeaderVO;
      
      public function EfficiencyHeader()
      {
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeTextFieldsListeners();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.summArmorTF = null;
         this.summCritsTF = null;
         this.summDamageTF = null;
         this.summAssistTF = null;
         this.summKillTF = null;
         this.summSpottedTF = null;
         this.summStunTF = null;
         this.summIconMC = null;
         this._headerVO = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.summIconMC.visible = false;
         this.summIconMC.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.summIconMC.visible = this._headerVO != null;
            if(this._headerVO)
            {
               this.summArmorTF.text = this._headerVO.armor;
               this.summCritsTF.text = this._headerVO.crits;
               this.summDamageTF.text = this._headerVO.damage;
               this.summAssistTF.text = this._headerVO.assist;
               this.summKillTF.text = this._headerVO.kill;
               this.summSpottedTF.text = this._headerVO.spotted;
               if(this._headerVO.isStunDataEnabled)
               {
                  this.summStunTF.text = this._headerVO.assistStun;
                  this.summIconMC.x = SUMM_ICON_STUN_X;
               }
               else
               {
                  this.summStunTF.visible = false;
                  this.summIconMC.x = SUMM_ICON_NO_STUN_X;
               }
               addEventListener(MouseEvent.ROLL_OVER,this.onTextFieldRollOverHandler,true);
               addEventListener(MouseEvent.ROLL_OUT,this.onTextFieldRollOutHandler,true);
            }
            else
            {
               this.removeTextFieldsListeners();
               this.summArmorTF.text = this.summCritsTF.text = this.summDamageTF.text = this.summAssistTF.text = this.summKillTF.text = this.summSpottedTF.text = this.summStunTF.text = Values.EMPTY_STR;
            }
         }
      }
      
      public function setData(param1:EfficiencyHeaderVO) : void
      {
         this._headerVO = param1;
         invalidateData();
      }
      
      private function removeTextFieldsListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onTextFieldRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onTextFieldRollOutHandler,true);
      }
      
      private function onTextFieldRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onTextFieldRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._headerVO)
         {
            return;
         }
         var _loc2_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.summArmorTF:
               _loc2_ = this._headerVO.armorTooltip;
               break;
            case this.summCritsTF:
               _loc2_ = this._headerVO.critsTooltip;
               break;
            case this.summDamageTF:
               _loc2_ = this._headerVO.damageTooltip;
               break;
            case this.summAssistTF:
               _loc2_ = this._headerVO.assistTooltip;
               break;
            case this.summKillTF:
               _loc2_ = this._headerVO.killTooltip;
               break;
            case this.summSpottedTF:
               _loc2_ = this._headerVO.spottedTooltip;
               break;
            case this.summStunTF:
               _loc2_ = this._headerVO.stunTooltip;
         }
         if(_loc2_ != Values.EMPTY_STR)
         {
            App.toolTipMgr.showComplex(_loc2_);
         }
      }
   }
}
