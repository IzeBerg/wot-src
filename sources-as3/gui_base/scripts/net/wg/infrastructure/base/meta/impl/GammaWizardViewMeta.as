package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.gamma.GammaInitVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class GammaWizardViewMeta extends AbstractScreen
   {
       
      
      public var onClose:Function;
      
      public var onApply:Function;
      
      public var onChangeGamma:Function;
      
      public var onReset:Function;
      
      public var updateTexture:Function;
      
      private var _gammaInitVO:GammaInitVO;
      
      public function GammaWizardViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._gammaInitVO)
         {
            this._gammaInitVO.dispose();
            this._gammaInitVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onApplyS() : void
      {
         App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
         this.onApply();
      }
      
      public function onChangeGammaS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onChangeGamma,"onChangeGamma" + Errors.CANT_NULL);
         this.onChangeGamma(param1);
      }
      
      public function onResetS() : void
      {
         App.utils.asserter.assertNotNull(this.onReset,"onReset" + Errors.CANT_NULL);
         this.onReset();
      }
      
      public function updateTextureS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.updateTexture,"updateTexture" + Errors.CANT_NULL);
         this.updateTexture(param1,param2,param3);
      }
      
      public final function as_initData(param1:Object) : void
      {
         var _loc2_:GammaInitVO = this._gammaInitVO;
         this._gammaInitVO = new GammaInitVO(param1);
         this.initData(this._gammaInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function initData(param1:GammaInitVO) : void
      {
         var _loc2_:String = "as_initData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
