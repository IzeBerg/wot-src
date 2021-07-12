package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MissionsViewBaseMeta extends BaseDAAPIComponent
   {
       
      
      public var dummyClicked:Function;
      
      private var _dummyVO:DummyVO;
      
      public function MissionsViewBaseMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         super.onDispose();
      }
      
      public function dummyClickedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.dummyClicked,"dummyClicked" + Errors.CANT_NULL);
         this.dummyClicked(param1);
      }
      
      public final function as_showDummy(param1:Object) : void
      {
         var _loc2_:DummyVO = this._dummyVO;
         this._dummyVO = new DummyVO(param1);
         this.showDummy(this._dummyVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function showDummy(param1:DummyVO) : void
      {
         var _loc2_:String = "as_showDummy" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
