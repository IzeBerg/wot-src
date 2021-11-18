package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipSkillVO extends DAAPIDataClass
   {
       
      
      private var _name:String = "";
      
      private var _descr:String = "";
      
      private var _type:String = "";
      
      private var _shortDescr:String = "";
      
      private var _level:Number = 0;
      
      public function ToolTipSkillVO(param1:Object)
      {
         super(param1);
      }
      
      public function get level() : Number
      {
         return this._level;
      }
      
      public function set level(param1:Number) : void
      {
         this._level = param1;
      }
      
      public function get shortDescr() : String
      {
         return this._shortDescr;
      }
      
      public function set shortDescr(param1:String) : void
      {
         this._shortDescr = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get descr() : String
      {
         return this._descr;
      }
      
      public function set descr(param1:String) : void
      {
         this._descr = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
   }
}
