package net.wg.gui.lobby.settings.components
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import scaleform.clik.controls.Button;
   
   public class SoundDeviceButtonBar extends ButtonBarEx
   {
      
      public static var DATA_LABEL_ID:String = "id";
      
      public static var DATA_LABEL_IMAGE:String = "image";
      
      public static var DATA_LABEL_SPEAKER_ID:String = "speakerId";
       
      
      public function SoundDeviceButtonBar()
      {
         super();
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         var _loc3_:Object = _dataProvider.requestItemAt(param2);
         var _loc4_:SoundDeviceTabButton = SoundDeviceTabButton(param1);
         if(_loc3_ && _loc3_.hasOwnProperty(DATA_LABEL_IMAGE))
         {
            _loc4_.iconSource(_loc3_[DATA_LABEL_IMAGE]);
         }
         if(_loc3_ && _loc3_.hasOwnProperty(DATA_LABEL_ID))
         {
            _loc4_.id = _loc3_[DATA_LABEL_ID];
         }
         if(_loc3_ && _loc3_.hasOwnProperty(DATA_LABEL_SPEAKER_ID))
         {
            _loc4_.speakerId = _loc3_[DATA_LABEL_SPEAKER_ID];
         }
         super.populateRendererData(param1,param2);
      }
      
      private function getRendererById(param1:String) : SoundDeviceTabButton
      {
         if(_renderers == null)
         {
            return null;
         }
         var _loc2_:int = _renderers.length;
         var _loc3_:SoundDeviceTabButton = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _renderers[_loc4_];
            if(param1 == _loc3_.id)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function updateDataById(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:SoundDeviceTabButton = this.getRendererById(param1);
         if(_loc4_)
         {
            _loc4_.label = param2;
            _loc4_.tooltip = param2;
            _loc4_.speakerId = param3;
         }
      }
   }
}
