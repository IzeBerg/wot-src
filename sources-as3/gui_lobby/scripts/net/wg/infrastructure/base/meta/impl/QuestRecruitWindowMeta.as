package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.QuestRecruitWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class QuestRecruitWindowMeta extends AbstractWindowView
   {
       
      
      public var onApply:Function;
      
      private var _questRecruitWindowVO:QuestRecruitWindowVO;
      
      public function QuestRecruitWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._questRecruitWindowVO)
         {
            this._questRecruitWindowVO.dispose();
            this._questRecruitWindowVO = null;
         }
         super.onDispose();
      }
      
      public function onApplyS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
         this.onApply(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:QuestRecruitWindowVO = this._questRecruitWindowVO;
         this._questRecruitWindowVO = new QuestRecruitWindowVO(param1);
         this.setInitData(this._questRecruitWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:QuestRecruitWindowVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
