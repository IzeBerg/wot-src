package net.wg.data.VO
{
   import net.wg.gui.interfaces.IExtendedUserVO;
   
   public class ExtendedUserVO extends UserVO implements IExtendedUserVO
   {
       
      
      private var _isPlayerSpeaking:Boolean = false;
      
      protected var _colors:Array;
      
      public function ExtendedUserVO(param1:Object)
      {
         super(param1);
      }
      
      public function get colors() : Array
      {
         return this._colors;
      }
      
      public function set colors(param1:Array) : void
      {
         this._colors = param1;
      }
      
      public function get isPlayerSpeaking() : Boolean
      {
         return this._isPlayerSpeaking;
      }
      
      public function set isPlayerSpeaking(param1:Boolean) : void
      {
         this._isPlayerSpeaking = param1;
      }
      
      public function getToolTip() : String
      {
         return fullName;
      }
   }
}
