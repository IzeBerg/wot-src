package net.wg.gui.messenger.data
{
   import net.wg.data.constants.generated.CONTACTS_ALIASES;
   
   public class GroupRulesVO
   {
       
      
      private var _rules:int = 0;
      
      public function GroupRulesVO(param1:int = 0)
      {
         super();
         this._rules = param1;
      }
      
      public static function fromObject(param1:Object) : GroupRulesVO
      {
         if(param1 && param1.hasOwnProperty("rules"))
         {
            return new GroupRulesVO(param1.rules);
         }
         return null;
      }
      
      public function getBitMask() : int
      {
         return this._rules;
      }
      
      public function isResizable() : Boolean
      {
         return (this._rules & CONTACTS_ALIASES.GROUP_IS_RESIZABLE) > 0;
      }
      
      public function isDropAllowed() : Boolean
      {
         return (this._rules & CONTACTS_ALIASES.GROUP_IS_DROP_ALLOWED) > 0;
      }
      
      public function canBeManaged() : Boolean
      {
         return (this._rules & CONTACTS_ALIASES.GROUP_CAN_BE_MANAGED) > 0;
      }
   }
}
