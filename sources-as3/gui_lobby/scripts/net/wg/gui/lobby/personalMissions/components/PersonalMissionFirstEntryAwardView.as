package net.wg.gui.lobby.personalMissions.components
{
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.lobby.personalMissions.data.OperationAwardsVO;
   import net.wg.infrastructure.base.meta.IPersonalMissionFirstEntryAwardViewMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionFirstEntryAwardViewMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionFirstEntryAwardView extends PersonalMissionFirstEntryAwardViewMeta implements IPersonalMissionFirstEntryAwardViewMeta
   {
      
      private static const TEXT_GAP:int = 180;
      
      private static const SMALL_TITLE_GAP:int = 45;
      
      private static const MIDDLE_TITLE_GAP:int = 90;
      
      private static const BIG_TITLE_GAP:int = 145;
      
      private static const RIBBON_WIDTH:int = 1600;
      
      private static const RIBBON_HEIGHT:int = 150;
      
      private static const CONTENT_GAP:int = 30;
       
      
      private var _awards:PersonalMissionAwardsContainer = null;
      
      private var _data:OperationAwardsVO = null;
      
      private var _awardsLinkage:String;
      
      public function PersonalMissionFirstEntryAwardView()
      {
         super();
      }
      
      override protected function update(param1:OperationAwardsVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            if(this._data.awardsLinkage != this._awardsLinkage)
            {
               this.clearAwards();
               this._awardsLinkage = this._data.awardsLinkage;
               this._awards = App.utils.classFactory.getComponent(this._data.awardsLinkage,PersonalMissionAwardsContainer);
               addChild(this._awards);
            }
            this._awards.setData(this._data.awards);
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._awards)
            {
               this._awards.x = width - RIBBON_WIDTH >> 1;
               this._awards.y = (height - RIBBON_HEIGHT >> 1) + CONTENT_GAP;
            }
            if(this._data)
            {
               _loc1_ = SMALL_TITLE_GAP;
               if(this._data.awardsLinkage == PERSONAL_MISSIONS_ALIASES.BADGES_1_LINKAGE)
               {
                  _loc1_ = MIDDLE_TITLE_GAP;
               }
               else if(this._data.awardsLinkage == PERSONAL_MISSIONS_ALIASES.BADGES_5_LINKAGE)
               {
                  _loc1_ = BIG_TITLE_GAP;
               }
               titleTF.y = this._awards.y - _loc1_ - titleTF.textHeight >> 0;
               subTitleTF.y = this._awards.y + TEXT_GAP >> 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearAwards();
         this._awards = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function getOperationAwardsVOForData(param1:Object) : OperationAwardsVO
      {
         return new OperationAwardsVO(param1);
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onEscapePressS();
      }
      
      private function clearAwards() : void
      {
         if(this._awards != null)
         {
            this._awards.stop();
            removeChild(this._awards);
            this._awards.dispose();
         }
      }
   }
}
