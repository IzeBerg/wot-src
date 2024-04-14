package net.wg.gui.lobby.personalMissions.components
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionAwardRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionAwardsContainer extends UIComponentEx
   {
      
      private static const START_FRAME:int = 1;
       
      
      public var award0:PersonalMissionAwardRenderer;
      
      public var award1:PersonalMissionAwardRenderer;
      
      public var award2:PersonalMissionAwardRenderer;
      
      public var award3:PersonalMissionAwardRenderer;
      
      public var award4:PersonalMissionAwardRenderer;
      
      private var _awardsList:Vector.<IUpdatableComponent>;
      
      private var _awardsData:Vector.<PersonalMissionAwardRendererVO>;
      
      public function PersonalMissionAwardsContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.award0.dispose();
         if(this.award1)
         {
            this.award1.dispose();
         }
         if(this.award2)
         {
            this.award2.dispose();
         }
         if(this.award3)
         {
            this.award3.dispose();
         }
         if(this.award4)
         {
            this.award4.dispose();
         }
         this.award0 = null;
         this.award1 = null;
         this.award2 = null;
         this.award3 = null;
         this.award4 = null;
         this._awardsList.splice(0,this._awardsList.length);
         this._awardsList = null;
         this._awardsData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._awardsList = new <IUpdatableComponent>[this.award0,this.award1,this.award2,this.award3,this.award4];
         gotoAndStop(START_FRAME);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:IUpdatableComponent = null;
         super.draw();
         if(this._awardsData && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._awardsData.length;
            _loc2_ = 0;
            while(_loc2_ != _loc1_)
            {
               App.utils.asserter.assert(_loc2_ < this._awardsList.length,Errors.WRONG_VALUE);
               _loc3_ = this._awardsList[_loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.update(this._awardsData[_loc2_]);
               }
               _loc2_++;
            }
            if(currentFrame == START_FRAME)
            {
               play();
            }
         }
      }
      
      public function setData(param1:Vector.<PersonalMissionAwardRendererVO>) : void
      {
         this._awardsData = param1;
         invalidateData();
      }
   }
}
