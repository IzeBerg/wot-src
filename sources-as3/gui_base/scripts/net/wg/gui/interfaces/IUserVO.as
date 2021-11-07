package net.wg.gui.interfaces
{
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IUserVO extends IDisposable
   {
       
      
      function get dbID() : Number;
      
      function get accID() : Number;
      
      function get fakeName() : String;
      
      function get userName() : String;
      
      function get clanAbbrev() : String;
      
      function set clanAbbrev(param1:String) : void;
      
      function get region() : String;
      
      function get tags() : Array;
      
      function get userProps() : IUserProps;
      
      function get igrType() : int;
      
      function get badgeVisualVO() : BadgeVisualVO;
      
      function get isAnonymized() : Boolean;
   }
}
