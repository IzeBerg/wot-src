package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.TweenConstraintsVO;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.ITween;
   
   public class TweenManagerMeta extends BaseDAAPIModule
   {
       
      
      public var createTween:Function;
      
      public var disposeTween:Function;
      
      public var disposeAll:Function;
      
      private var _tweenConstraintsVO:TweenConstraintsVO;
      
      public function TweenManagerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tweenConstraintsVO)
         {
            this._tweenConstraintsVO.dispose();
            this._tweenConstraintsVO = null;
         }
         super.onDispose();
      }
      
      public function createTweenS(param1:ITween) : void
      {
         App.utils.asserter.assertNotNull(this.createTween,"createTween" + Errors.CANT_NULL);
         this.createTween(param1);
      }
      
      public function disposeTweenS(param1:ITween) : void
      {
         App.utils.asserter.assertNotNull(this.disposeTween,"disposeTween" + Errors.CANT_NULL);
         this.disposeTween(param1);
      }
      
      public function disposeAllS() : void
      {
         App.utils.asserter.assertNotNull(this.disposeAll,"disposeAll" + Errors.CANT_NULL);
         this.disposeAll();
      }
      
      public final function as_setDataFromXml(param1:Object) : void
      {
         var _loc2_:TweenConstraintsVO = this._tweenConstraintsVO;
         this._tweenConstraintsVO = new TweenConstraintsVO(param1);
         this.setDataFromXml(this._tweenConstraintsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setDataFromXml(param1:TweenConstraintsVO) : void
      {
         var _loc2_:String = "as_setDataFromXml" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
