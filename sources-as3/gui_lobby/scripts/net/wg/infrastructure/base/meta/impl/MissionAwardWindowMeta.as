package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.MissionAwardWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MissionAwardWindowMeta extends AbstractWindowView
   {
       
      
      public var onCurrentQuestClick:Function;
      
      public var onNextQuestClick:Function;
      
      private var _missionAwardWindowVO:MissionAwardWindowVO;
      
      public function MissionAwardWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._missionAwardWindowVO)
         {
            this._missionAwardWindowVO.dispose();
            this._missionAwardWindowVO = null;
         }
         super.onDispose();
      }
      
      public function onCurrentQuestClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCurrentQuestClick,"onCurrentQuestClick" + Errors.CANT_NULL);
         this.onCurrentQuestClick();
      }
      
      public function onNextQuestClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onNextQuestClick,"onNextQuestClick" + Errors.CANT_NULL);
         this.onNextQuestClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:MissionAwardWindowVO = this._missionAwardWindowVO;
         this._missionAwardWindowVO = new MissionAwardWindowVO(param1);
         this.setData(this._missionAwardWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:MissionAwardWindowVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
