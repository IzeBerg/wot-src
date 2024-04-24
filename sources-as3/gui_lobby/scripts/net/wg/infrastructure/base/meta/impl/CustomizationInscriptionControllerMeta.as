package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationInscriptionHintVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationInscriptionControllerMeta extends BaseDAAPIComponent
   {
       
      
      public var sendChar:Function;
      
      public var finish:Function;
      
      public var removeChar:Function;
      
      public var deleteAll:Function;
      
      private var _customizationInscriptionHintVO:CustomizationInscriptionHintVO;
      
      private var _customizationInscriptionHintVO1:CustomizationInscriptionHintVO;
      
      public function CustomizationInscriptionControllerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._customizationInscriptionHintVO)
         {
            this._customizationInscriptionHintVO.dispose();
            this._customizationInscriptionHintVO = null;
         }
         if(this._customizationInscriptionHintVO1)
         {
            this._customizationInscriptionHintVO1.dispose();
            this._customizationInscriptionHintVO1 = null;
         }
         super.onDispose();
      }
      
      public function sendCharS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.sendChar,"sendChar" + Errors.CANT_NULL);
         this.sendChar(param1);
      }
      
      public function finishS() : void
      {
         App.utils.asserter.assertNotNull(this.finish,"finish" + Errors.CANT_NULL);
         this.finish();
      }
      
      public function removeCharS() : void
      {
         App.utils.asserter.assertNotNull(this.removeChar,"removeChar" + Errors.CANT_NULL);
         this.removeChar();
      }
      
      public function deleteAllS() : void
      {
         App.utils.asserter.assertNotNull(this.deleteAll,"deleteAll" + Errors.CANT_NULL);
         this.deleteAll();
      }
      
      public final function as_invalidInscription(param1:Object) : void
      {
         var _loc2_:CustomizationInscriptionHintVO = this._customizationInscriptionHintVO;
         this._customizationInscriptionHintVO = new CustomizationInscriptionHintVO(param1);
         this.invalidInscription(this._customizationInscriptionHintVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_showHint(param1:Object) : void
      {
         var _loc2_:CustomizationInscriptionHintVO = this._customizationInscriptionHintVO1;
         this._customizationInscriptionHintVO1 = new CustomizationInscriptionHintVO(param1);
         this.showHint(this._customizationInscriptionHintVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function invalidInscription(param1:CustomizationInscriptionHintVO) : void
      {
         var _loc2_:String = "as_invalidInscription" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showHint(param1:CustomizationInscriptionHintVO) : void
      {
         var _loc2_:String = "as_showHint" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
