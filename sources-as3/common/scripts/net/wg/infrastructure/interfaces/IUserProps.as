package net.wg.infrastructure.interfaces
{
   public interface IUserProps
   {
       
      
      function get fakeName() : String;
      
      function set fakeName(param1:String) : void;
      
      function get userName() : String;
      
      function set userName(param1:String) : void;
      
      function get clanAbbrev() : String;
      
      function set clanAbbrev(param1:String) : void;
      
      function get region() : String;
      
      function set region(param1:String) : void;
      
      function get igrType() : int;
      
      function set igrType(param1:int) : void;
      
      function get prefix() : String;
      
      function set prefix(param1:String) : void;
      
      function get suffix() : String;
      
      function set suffix(param1:String) : void;
      
      function get igrVspace() : int;
      
      function set igrVspace(param1:int) : void;
      
      function get rgb() : Number;
      
      function set rgb(param1:Number) : void;
      
      function get tags() : Array;
      
      function set tags(param1:Array) : void;
      
      function get isTeamKiller() : Boolean;
      
      function set isTeamKiller(param1:Boolean) : void;
      
      function get isAnonymized() : Boolean;
   }
}
