package net.wg.gui.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class DataClassItemVO extends DAAPIDataClass
   {
      
      private static const VO_DATA_FIELD_NAME:String = "voData";
      
      private static const VO_CLASS_NAME_FIELD_NAME:String = "voClassName";
       
      
      private var _voClassName:String = "";
      
      private var _rawVoData:Object = null;
      
      private var _voData:DAAPIDataClass = null;
      
      public function DataClassItemVO(param1:Object)
      {
         super(param1);
      }
      
      override public function fromHash(param1:Object) : void
      {
         super.fromHash(param1);
         var _loc2_:Class = App.utils.classFactory.getClass(this._voClassName);
         this._voData = new _loc2_(this._rawVoData);
         this._rawVoData = null;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VO_DATA_FIELD_NAME)
         {
            this._rawVoData = param2;
            return false;
         }
         if(param1 == VO_CLASS_NAME_FIELD_NAME)
         {
            this._voClassName = param2 as String;
            if(StringUtils.isEmpty(this._voClassName))
            {
               App.utils.asserter.assert(false,"voClassName" + Errors.CANT_EMPTY);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.voData != null)
         {
            this._voData.dispose();
            this._voData = null;
         }
         this._rawVoData = null;
         super.onDispose();
      }
      
      public function get voData() : DAAPIDataClass
      {
         return this._voData;
      }
      
      public function get voClassName() : String
      {
         return this._voClassName;
      }
   }
}
