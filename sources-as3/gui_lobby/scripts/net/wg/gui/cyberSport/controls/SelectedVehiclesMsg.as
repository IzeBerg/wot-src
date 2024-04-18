package net.wg.gui.cyberSport.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class SelectedVehiclesMsg extends MovieClip
   {
      
      private static const TF_POS_NORMAL:Number = -140;
      
      private static const TF_POS_WARN:Number = -160;
       
      
      public var textField:TextField;
      
      public var warningIcon:Sprite;
      
      public function SelectedVehiclesMsg()
      {
         super();
      }
      
      public function update(param1:String, param2:Boolean = false) : void
      {
         this.textField.htmlText = param1;
         this.warningIcon.visible = param2;
         this.textField.x = !!param2 ? Number(TF_POS_WARN) : Number(TF_POS_NORMAL);
      }
   }
}
