package net.wg.gui.battle.battleloading
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class SimpleBattleLoading extends BaseBattleLoading
   {
      
      private static const TF_LEFT_OFFSET_IN_PERCENT:Number = 0.1;
      
      private static const TF_BOTTOM_OFFSET_IN_PERCENT:Number = 0.07;
       
      
      public var form:SimpleBattleLoadingForm;
      
      public var mainText:TextField;
      
      private var _stageHeight:int = 0;
      
      private var _stageWidth:int = 0;
      
      public function SimpleBattleLoading()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.mainText.wordWrap = true;
         this.mainText.multiline = true;
         this.mainText.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.form.dispose();
         this.form = null;
         this.mainText = null;
         super.onDispose();
      }
      
      override public function as_setProgress(param1:Number) : void
      {
         this.form.updateProgress(param1);
      }
      
      override public function getContentY() : int
      {
         return this.form.y;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.form.x = param1 >> 1;
         this._stageHeight = param2;
         this._stageWidth = param1;
         this.updatePositions();
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function as_setMapIcon(param1:String) : void
      {
      }
      
      override public function as_setTip(param1:String) : void
      {
         this.mainText.htmlText = param1;
         this.updatePositions();
      }
      
      override public function as_setTipTitle(param1:String) : void
      {
      }
      
      override public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setPersonalStatus(param1:uint) : void
      {
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      override public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
      }
      
      override public function hasAmmunitionPanel(param1:Boolean) : void
      {
      }
      
      protected function updatePositions() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._stageHeight * TF_BOTTOM_OFFSET_IN_PERCENT;
         var _loc2_:Number = this._stageHeight - _loc1_ - this.form.height;
         this.form.y = _loc2_;
         this.form.x = this._stageWidth - this.form.width >> 1;
         this.mainText.y = _loc2_ - this.mainText.height - _loc1_;
         this.mainText.x = int(this._stageWidth * TF_LEFT_OFFSET_IN_PERCENT);
      }
   }
}
