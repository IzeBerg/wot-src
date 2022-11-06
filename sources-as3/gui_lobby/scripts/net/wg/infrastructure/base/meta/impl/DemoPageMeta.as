package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.demoPage.ButtonDemoVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class DemoPageMeta extends AbstractView
   {
       
      
      public var onButtonClicked:Function;
      
      private var _dataProviderButtonDemoVO:DataProvider;
      
      public function DemoPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ButtonDemoVO = null;
         if(this._dataProviderButtonDemoVO)
         {
            for each(_loc1_ in this._dataProviderButtonDemoVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderButtonDemoVO.cleanUp();
            this._dataProviderButtonDemoVO = null;
         }
         super.onDispose();
      }
      
      public function onButtonClickedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onButtonClicked,"onButtonClicked" + Errors.CANT_NULL);
         this.onButtonClicked(param1);
      }
      
      public final function as_setContent(param1:Array) : void
      {
         var _loc5_:ButtonDemoVO = null;
         var _loc2_:DataProvider = this._dataProviderButtonDemoVO;
         this._dataProviderButtonDemoVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderButtonDemoVO[_loc4_] = new ButtonDemoVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setContent(this._dataProviderButtonDemoVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setContent(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setContent" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
