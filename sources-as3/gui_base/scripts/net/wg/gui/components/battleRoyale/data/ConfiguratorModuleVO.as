package net.wg.gui.components.battleRoyale.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ConfiguratorModuleVO extends DAAPIDataClass
   {
      
      private static const POTENTIAL_LINKS_LBL:String = "potentialLinks";
       
      
      public var icon:String = "";
      
      public var intCD:int = 0;
      
      public var activeLink:int = -1;
      
      public var selected:Boolean = false;
      
      public var available:Boolean = false;
      
      public var gap:int = 0;
      
      private var _potentialLinks:Vector.<int>;
      
      public function ConfiguratorModuleVO(param1:Object)
      {
         this._potentialLinks = new Vector.<int>(0);
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param1 == POTENTIAL_LINKS_LBL)
         {
            this._potentialLinks.length = 0;
            _loc3_ = param2 as Array;
            if(_loc3_)
            {
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this._potentialLinks.push(_loc3_[_loc5_]);
                  _loc5_++;
               }
            }
            else
            {
               App.utils.asserter.assert(false,Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._potentialLinks.length = 0;
         this._potentialLinks = null;
         super.onDispose();
      }
      
      public function update(param1:ConfiguratorModuleVO) : void
      {
         this.activeLink = param1.activeLink;
         this.selected = param1.selected;
         this.available = param1.available;
      }
      
      public function get potentialLinks() : Vector.<int>
      {
         return this._potentialLinks;
      }
   }
}
