package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.TrainingFormInfoVO;
   import net.wg.data.VO.TrainingFormVO;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TrainingFormMeta extends AbstractView
   {
       
      
      public var joinTrainingRequest:Function;
      
      public var createTrainingRequest:Function;
      
      public var onEscape:Function;
      
      public var onLeave:Function;
      
      private var _trainingFormInfoVO:TrainingFormInfoVO;
      
      private var _trainingFormVO:TrainingFormVO;
      
      public function TrainingFormMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._trainingFormInfoVO)
         {
            this._trainingFormInfoVO.dispose();
            this._trainingFormInfoVO = null;
         }
         if(this._trainingFormVO)
         {
            this._trainingFormVO.dispose();
            this._trainingFormVO = null;
         }
         super.onDispose();
      }
      
      public function joinTrainingRequestS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.joinTrainingRequest,"joinTrainingRequest" + Errors.CANT_NULL);
         this.joinTrainingRequest(param1);
      }
      
      public function createTrainingRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.createTrainingRequest,"createTrainingRequest" + Errors.CANT_NULL);
         this.createTrainingRequest();
      }
      
      public function onEscapeS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
         this.onEscape();
      }
      
      public function onLeaveS() : void
      {
         App.utils.asserter.assertNotNull(this.onLeave,"onLeave" + Errors.CANT_NULL);
         this.onLeave();
      }
      
      public final function as_setInfo(param1:Object) : void
      {
         var _loc2_:TrainingFormInfoVO = this._trainingFormInfoVO;
         this._trainingFormInfoVO = new TrainingFormInfoVO(param1);
         this.setInfo(this._trainingFormInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setList(param1:Object) : void
      {
         var _loc2_:TrainingFormVO = this._trainingFormVO;
         this._trainingFormVO = new TrainingFormVO(param1);
         this.setList(this._trainingFormVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInfo(param1:TrainingFormInfoVO) : void
      {
         var _loc2_:String = "as_setInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setList(param1:TrainingFormVO) : void
      {
         var _loc2_:String = "as_setList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
