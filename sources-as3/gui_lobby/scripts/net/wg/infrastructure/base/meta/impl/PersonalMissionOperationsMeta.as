package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.OperationDataVO;
   import net.wg.gui.lobby.personalMissions.data.OperationTitleVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionOperationsMeta extends AbstractScreen
   {
       
      
      public var closeView:Function;
      
      public var onOperationClick:Function;
      
      public var showInfo:Function;
      
      private var _vectorOperationDataVO:Vector.<OperationDataVO>;
      
      private var _operationTitleVO:OperationTitleVO;
      
      public function PersonalMissionOperationsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:OperationDataVO = null;
         if(this._vectorOperationDataVO)
         {
            for each(_loc1_ in this._vectorOperationDataVO)
            {
               _loc1_.dispose();
            }
            this._vectorOperationDataVO.splice(0,this._vectorOperationDataVO.length);
            this._vectorOperationDataVO = null;
         }
         if(this._operationTitleVO)
         {
            this._operationTitleVO.dispose();
            this._operationTitleVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function onOperationClickS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onOperationClick,"onOperationClick" + Errors.CANT_NULL);
         this.onOperationClick(param1,param2);
      }
      
      public function showInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.showInfo,"showInfo" + Errors.CANT_NULL);
         this.showInfo();
      }
      
      public final function as_setOperations(param1:Array) : void
      {
         var _loc5_:OperationDataVO = null;
         var _loc2_:Vector.<OperationDataVO> = this._vectorOperationDataVO;
         this._vectorOperationDataVO = new Vector.<OperationDataVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorOperationDataVO[_loc4_] = new OperationDataVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setOperations(this._vectorOperationDataVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setTitle(param1:Object) : void
      {
         var _loc2_:OperationTitleVO = this._operationTitleVO;
         this._operationTitleVO = new OperationTitleVO(param1);
         this.setTitle(this._operationTitleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setOperations(param1:Vector.<OperationDataVO>) : void
      {
         var _loc2_:String = "as_setOperations" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTitle(param1:OperationTitleVO) : void
      {
         var _loc2_:String = "as_setTitle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
