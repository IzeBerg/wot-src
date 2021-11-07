package net.wg.gui.components.battleDamagePanel
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEDAMAGELOG_IMAGES;
   import net.wg.gui.components.battleDamagePanel.components.DamageLogDetailsController;
   import net.wg.gui.components.battleDamagePanel.components.DefaultSummaryImages;
   import net.wg.gui.components.battleDamagePanel.components.SummaryAnimation;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.battleDamagePanel.models.MessageRenderModel;
   import net.wg.infrastructure.base.meta.IBattleDamageLogPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleDamageLogPanelMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class BattleDamageLogPanel extends BattleDamageLogPanelMeta implements IBattleDamageLogPanelMeta, IDisplayableComponent
   {
      
      private static const Y_POSITION_STEP_TF:int = 22;
      
      private static const ANIMATION_PADDING:Number = 10;
      
      private static const TOP_DETAILS_OFFSET_Y:Number = 285;
      
      private static const BOTTOM_DETAILS_POS_Y:Number = 87;
      
      public static const SCREEN_BORDER_X_POS:Number = -229;
      
      public static const PLAYERS_PANEL_OFFSET:Number = -246;
      
      private static const SETTINGS_TOP_X_POS:Number = 49;
      
      private static const SETTINGS_TOP_Y_POS:Number = -273;
       
      
      public var summaryDamageBlock:DefaultSummaryImages = null;
      
      public var summaryDefenceBlock:DefaultSummaryImages = null;
      
      public var summarySupportBlock:DefaultSummaryImages = null;
      
      public var summaryStunBlock:DefaultSummaryImages = null;
      
      public var damageValTF:TextField = null;
      
      public var defenceValTF:TextField = null;
      
      public var supportValTF:TextField = null;
      
      public var stunValTF:TextField = null;
      
      public var damageAnimation:SummaryAnimation = null;
      
      public var defenceAnimation:SummaryAnimation = null;
      
      public var supportAnimation:SummaryAnimation = null;
      
      public var stunAnimation:SummaryAnimation = null;
      
      private var _damageLogDetailsTopController:DamageLogDetailsController = null;
      
      private var _damageLogDetailsBottomController:DamageLogDetailsController = null;
      
      private var _additionalRowsCount:int = 3;
      
      private var _detailActionRowsCount:int = 0;
      
      private var _currentPositionTF:int = 0;
      
      private var _isInited:Boolean = false;
      
      private var _detailsBottomContainer:Sprite = null;
      
      private var _detailsTopContainer:Sprite = null;
      
      private var _atlasName:String = "";
      
      private var _topContainerXPos:Number = 0;
      
      private var _topDetailsOffsetY:Number = 0;
      
      public function BattleDamageLogPanel()
      {
         super();
         visible = false;
         this._detailsTopContainer = new Sprite();
         this._detailsTopContainer.name = "detailsTopContainer";
         this._detailsBottomContainer = new Sprite();
         this._detailsBottomContainer.name = "detailsBottomContainer";
         this._topDetailsOffsetY = TOP_DETAILS_OFFSET_Y;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.damageValTF.visible = false;
         this.defenceValTF.visible = false;
         this.supportValTF.visible = false;
         this.stunValTF.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this._detailsTopContainer = null;
         this._detailsBottomContainer = null;
         this._damageLogDetailsTopController.dispose();
         this._damageLogDetailsTopController = null;
         this._damageLogDetailsBottomController.dispose();
         this._damageLogDetailsBottomController = null;
         this.summaryDamageBlock.dispose();
         this.summaryDamageBlock = null;
         this.summaryDefenceBlock.dispose();
         this.summaryDefenceBlock = null;
         this.summarySupportBlock.dispose();
         this.summarySupportBlock = null;
         this.summaryStunBlock.dispose();
         this.summaryStunBlock = null;
         this.damageValTF = null;
         this.defenceValTF = null;
         this.supportValTF = null;
         this.stunValTF = null;
         this.damageAnimation.dispose();
         this.damageAnimation = null;
         this.defenceAnimation.dispose();
         this.defenceAnimation = null;
         this.supportAnimation.dispose();
         this.supportAnimation = null;
         this.stunAnimation.dispose();
         this.stunAnimation = null;
         super.onDispose();
      }
      
      override protected function detailStatsTop(param1:Boolean, param2:Boolean, param3:Vector.<MessageRenderModel>) : void
      {
         this._damageLogDetailsTopController.detailsStats(param1,param2,param3);
      }
      
      override protected function detailStatsBottom(param1:Boolean, param2:Boolean, param3:Vector.<MessageRenderModel>) : void
      {
         this._damageLogDetailsBottomController.detailsStats(param1,param2,param3);
      }
      
      public function as_addDetailMessageBottom(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this._damageLogDetailsBottomController.addDetailsMessage(param1,param2,param3,param4,param5,param6);
      }
      
      public function as_addDetailMessageTop(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this._damageLogDetailsTopController.addDetailsMessage(param1,param2,param3,param4,param5,param6);
      }
      
      public function as_isDownAltButton(param1:Boolean) : void
      {
         this._damageLogDetailsBottomController.isDownAltButton(param1);
         this._damageLogDetailsTopController.isDownAltButton(param1);
      }
      
      public function as_isDownCtrlButton(param1:Boolean) : void
      {
         this._damageLogDetailsBottomController.isDownCtrlButton(param1);
         this._damageLogDetailsTopController.isDownCtrlButton(param1);
      }
      
      public function as_setSettingsDamageLogComponent(param1:Boolean, param2:Boolean) : void
      {
         this.setSettingsDamageLogComponent(param1,param2);
      }
      
      public function as_summaryStats(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.setSummaryStats(param1,param2,param3,param4);
      }
      
      public function as_updateSummaryAssistValue(param1:String) : void
      {
         this.updateSummaryCounter(this.supportAnimation,this.supportValTF,param1);
      }
      
      public function as_updateSummaryBlockedValue(param1:String) : void
      {
         this.updateSummaryCounter(this.defenceAnimation,this.defenceValTF,param1);
      }
      
      public function as_updateSummaryDamageValue(param1:String) : void
      {
         this.updateSummaryCounter(this.damageAnimation,this.damageValTF,param1);
      }
      
      public function as_updateSummaryStunValue(param1:String) : void
      {
         this.updateSummaryCounter(this.stunAnimation,this.stunValTF,param1);
      }
      
      public function init(param1:String) : void
      {
         this._atlasName = param1;
         addChild(this._detailsTopContainer);
         this._damageLogDetailsTopController = new DamageLogDetailsController(this._detailsTopContainer,true,this._atlasName);
         addChild(this._detailsBottomContainer);
         this._damageLogDetailsBottomController = new DamageLogDetailsController(this._detailsBottomContainer,false,this._atlasName);
         this.summaryDamageBlock.visible = this.summaryDefenceBlock.visible = this.summarySupportBlock.visible = this.summaryStunBlock.visible = false;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
      
      public function setDetailActionCount(param1:int) : void
      {
         this._detailActionRowsCount = param1;
         this._damageLogDetailsTopController.setDetailsCount(this._detailActionRowsCount);
         this.updateContainersPosition();
      }
      
      public function setSettingsDamageLogComponent(param1:Boolean, param2:Boolean) : void
      {
         visible = param1;
         this._damageLogDetailsTopController.setColorBlind(param2);
         this._damageLogDetailsBottomController.setColorBlind(param2);
      }
      
      public function setSummaryStats(param1:String, param2:String, param3:String, param4:String) : void
      {
         if(!this._isInited)
         {
            this.summaryDamageBlock.init(this._atlasName);
            this.summaryDefenceBlock.init(this._atlasName);
            this.summarySupportBlock.init(this._atlasName);
            this.summaryStunBlock.init(this._atlasName);
            this.summaryDamageBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_TOTAL,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_16X16);
            this.summaryDefenceBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_TOTAL,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_REFLECT_16X16);
            this.summarySupportBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_TOTAL,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_ASSIST_16X16);
            this.summaryStunBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_TOTAL,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_STUN_16X16);
            this._isInited = true;
         }
         this._currentPositionTF = 0;
         this._additionalRowsCount = 0;
         this.initializeSummaryElements(param1,this.damageValTF,this.summaryDamageBlock,this.damageAnimation);
         this.initializeSummaryElements(param2,this.defenceValTF,this.summaryDefenceBlock,this.defenceAnimation);
         this.initializeSummaryElements(param3,this.supportValTF,this.summarySupportBlock,this.supportAnimation);
         this.initializeSummaryElements(param4,this.stunValTF,this.summaryStunBlock,this.stunAnimation);
         this.updateContainersPosition();
      }
      
      public function settingsDetailStatsBottom(param1:Boolean, param2:Boolean, param3:Vector.<MessageRenderModel>) : void
      {
         this.detailStatsBottom(param1,param2,param3);
      }
      
      public function settingsDetailStatsTop(param1:Boolean, param2:Vector.<MessageRenderModel>) : void
      {
         this.detailStatsTop(param1,false,param2);
      }
      
      public function updateContainersPosition() : void
      {
         this._damageLogDetailsBottomController.setDetailsCount(this._detailActionRowsCount + this._additionalRowsCount);
         if(this._atlasName == ATLAS_CONSTANTS.BATTLE_ATLAS)
         {
            this._detailsTopContainer.x = this._topContainerXPos;
         }
         else
         {
            this._detailsTopContainer.x = SETTINGS_TOP_X_POS;
            this._detailsTopContainer.y = SETTINGS_TOP_Y_POS;
         }
         this._detailsBottomContainer.y = BOTTOM_DETAILS_POS_Y - this._additionalRowsCount * BattleDamageLogConstants.RENDER_STEP_SIZE;
      }
      
      public function setTopDetailsOffsetY(param1:Number) : void
      {
         this._topDetailsOffsetY = param1;
      }
      
      public function updateSize(param1:Number, param2:Number) : void
      {
         this._detailsTopContainer.y = -param2 + this._topDetailsOffsetY;
      }
      
      public function updateTopContainerPosition(param1:Number) : void
      {
         this._topContainerXPos = param1;
         this._detailsTopContainer.x = param1;
         if(this._damageLogDetailsTopController != null)
         {
            this._damageLogDetailsTopController.updateRenderersBG(param1 == SCREEN_BORDER_X_POS);
         }
      }
      
      private function initializeSummaryElements(param1:String, param2:TextField, param3:DefaultSummaryImages, param4:SummaryAnimation) : void
      {
         var _loc5_:Boolean = param1 != null;
         param2.visible = _loc5_;
         param3.visible = _loc5_;
         param4.visible = _loc5_;
         if(!_loc5_)
         {
            ++this._additionalRowsCount;
            return;
         }
         param2.text = param1;
         param2.y = this._currentPositionTF;
         this._currentPositionTF += Y_POSITION_STEP_TF;
         param3.y = param2.y + (param2.height - param3.height >> 1);
         param4.x = param2.x + ANIMATION_PADDING;
         param4.y = param2.y + (param2.height >> 1);
      }
      
      private function updateSummaryCounter(param1:SummaryAnimation, param2:TextField, param3:String) : void
      {
         if(param2.visible)
         {
            param1.playAnimation();
            param2.text = param3;
         }
      }
   }
}
