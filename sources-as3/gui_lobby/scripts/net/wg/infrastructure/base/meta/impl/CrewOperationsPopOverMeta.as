package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.crewOperations.CrewOperationsInitVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CrewOperationsPopOverMeta extends SmartPopOverView
   {
       
      
      public var invokeOperation:Function;
      
      private var _crewOperationsInitVO:CrewOperationsInitVO;
      
      public function CrewOperationsPopOverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._crewOperationsInitVO)
         {
            this._crewOperationsInitVO.dispose();
            this._crewOperationsInitVO = null;
         }
         super.onDispose();
      }
      
      public function invokeOperationS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.invokeOperation,"invokeOperation" + Errors.CANT_NULL);
         this.invokeOperation(param1);
      }
      
      public final function as_update(param1:Object) : void
      {
         var _loc2_:CrewOperationsInitVO = this._crewOperationsInitVO;
         this._crewOperationsInitVO = new CrewOperationsInitVO(param1);
         this.update(this._crewOperationsInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function update(param1:CrewOperationsInitVO) : void
      {
         var _loc2_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
