package net.wg.gui.interfaces
{
   public interface IExtendedUserVO extends IUserVO
   {
       
      
      function toHash() : Object;
      
      function getToolTip() : String;
   }
}
