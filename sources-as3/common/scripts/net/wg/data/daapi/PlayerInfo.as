package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PlayerInfo extends DAAPIDataClass
   {
       
      
      private var _dbID:Number;
      
      private var _isFriend:Boolean;
      
      private var _isIgnored:Boolean;
      
      private var _isMuted:Boolean;
      
      private var _displayName:String = "";
      
      private var _isEnabledInRoaming:Boolean = true;
      
      private var _canAddToFriend:Boolean = false;
      
      private var _canAddToIgnore:Boolean = false;
      
      private var _canDoDenunciations:Boolean = false;
      
      private var _canCreateChannel:Boolean = false;
      
      public function PlayerInfo(param1:Object)
      {
         super(param1);
      }
      
      public function get dbID() : Number
      {
         return this._dbID;
      }
      
      public function set dbID(param1:Number) : void
      {
         this._dbID = param1;
      }
      
      public function get canAddToFriend() : Boolean
      {
         return this._canAddToFriend;
      }
      
      public function set canAddToFriend(param1:Boolean) : void
      {
         this._canAddToFriend = param1;
      }
      
      public function get canAddToIgnore() : Boolean
      {
         return this._canAddToIgnore;
      }
      
      public function set canAddToIgnore(param1:Boolean) : void
      {
         this._canAddToIgnore = param1;
      }
      
      public function get canDoDenunciations() : Boolean
      {
         return this._canDoDenunciations;
      }
      
      public function set canDoDenunciations(param1:Boolean) : void
      {
         this._canDoDenunciations = param1;
      }
      
      public function get canCreateChannel() : Boolean
      {
         return this._canCreateChannel;
      }
      
      public function set canCreateChannel(param1:Boolean) : void
      {
         this._canCreateChannel = param1;
      }
      
      public function get displayName() : String
      {
         return this._displayName;
      }
      
      public function set displayName(param1:String) : void
      {
         this._displayName = param1;
      }
      
      public function get isMuted() : Boolean
      {
         return this._isMuted;
      }
      
      public function set isMuted(param1:Boolean) : void
      {
         this._isMuted = param1;
      }
      
      public function get isIgnored() : Boolean
      {
         return this._isIgnored;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         this._isIgnored = param1;
      }
      
      public function get isFriend() : Boolean
      {
         return this._isFriend;
      }
      
      public function set isFriend(param1:Boolean) : void
      {
         this._isFriend = param1;
      }
      
      public function get isEnabledInRoaming() : Boolean
      {
         return this._isEnabledInRoaming;
      }
      
      public function set isEnabledInRoaming(param1:Boolean) : void
      {
         this._isEnabledInRoaming = param1;
      }
   }
}
