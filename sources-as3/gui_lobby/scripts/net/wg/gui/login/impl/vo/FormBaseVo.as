package net.wg.gui.login.impl.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.login.IFormBaseVo;
   
   public class FormBaseVo extends DAAPIDataClass implements IFormBaseVo
   {
       
      
      private var _invalidType:String = "";
      
      private var _baseDisposed:Boolean = false;
      
      public function FormBaseVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         App.utils.asserter.assert(!this._baseDisposed,"Dispose method is called again");
         this._baseDisposed = true;
         super.onDispose();
      }
      
      public function get invalidType() : String
      {
         return this._invalidType;
      }
      
      public function set invalidType(param1:String) : void
      {
         this._invalidType = param1;
      }
   }
}
