package net.wg.gui.messenger.data
{
   public class ContactsSettingsViewInitDataVO extends ContactsViewInitDataVO
   {
       
      
      private var _mainDataVO:ContactsSettingsDataVO;
      
      public var mainData:Object;
      
      public function ContactsSettingsViewInitDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "mainData")
         {
            this._mainDataVO = new ContactsSettingsDataVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      public function get mainDataVO() : ContactsSettingsDataVO
      {
         return this._mainDataVO;
      }
   }
}
